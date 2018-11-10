module JekyllDeployShosetsu
  module Deployers
    class Kakuyomu
      attr_reader :agent

      def initialize(agent: KakuyomuAgent.new)
        @agent = agent
      end

      def deploy(site)
        email    = site.config['kakuyomu']['email']
        password = site.config['kakuyomu']['password']
        agent.login!(email: email, password: password)

        work_id = site.config['kakuyomu']['work_id']

        site.posts.docs.each do |post|
          post.output = Jekyll::Renderer.new(site, post).run

          kakuyomu_config = post['kakuyomu'] || {}
          next if kakuyomu_config['ignore']

          if kakuyomu_config['url']
            episode_id = KakuyomuAgent::UrlUtils.extract_episode_id(kakuyomu_config['url'])
            url        = agent.update_episode(work_id: work_id, episode_id: episode_id, title: post['title'], body: post.output)
            Jekyll.logger.info 'Updated:', "#{post.basename} #{url}"
          else
            url = agent.create_episode(work_id: work_id, title: post['title'], body: post.output)
            Jekyll.logger.info 'Created:', "#{post.basename} #{url}"
            add_kakuyomu_url_config(post, url)
          end
        end
      end

      private

      def add_kakuyomu_url_config(post, url)
        content    = File.read(post.path)
        config     = content[Jekyll::Document::YAML_FRONT_MATTER_REGEXP, 1]
        new_config = config + <<~YAML
          kakuyomu:
            url: #{url}
        YAML
        new_content = content.gsub(config, new_config)
        File.write(post.path, new_content)
      end
    end
  end
end
