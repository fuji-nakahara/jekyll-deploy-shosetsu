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
          kakuyomu_config = post['kakuyomu'] || {}
          next if kakuyomu_config['ignore']

          post.output = Jekyll::Renderer.new(site, post).run

          if kakuyomu_config['url']
            episode_id = KakuyomuAgent::UrlHelper.extract_episode_id(kakuyomu_config['url'])
            url        = agent.update_episode(work_id: work_id, episode_id: episode_id, title: post['title'], body: post.output, date: post.date)
            Jekyll.logger.info 'Updated:', "#{post.basename} #{url}"
          else
            url = agent.create_episode(work_id: work_id, title: post['title'], body: post.output, date: post.date)
            Jekyll.logger.info 'Created:', "#{post.basename} #{url}"
            Util.append_yaml_front_matter post.path, <<~YAML
              kakuyomu:
                url: #{url}
            YAML
          end
        end
      end
    end
  end
end
