module JekyllDeployShosetsu
  module Deployers
    class Narou
      attr_reader :agent

      def initialize(agent: NarouAgent.new)
        @agent = agent
      end

      def deploy(site)
        id       = site.config['narou']['id']
        password = site.config['narou']['password']
        agent.login!(id: id, password: password)

        ncode = site.config['narou']['ncode']

        site.posts.docs.each do |post|
          narou_config = post['narou'] || {}
          next if narou_config['ignore']

          post.output = Jekyll::Renderer.new(site, post).run

          if narou_config['url']
            part_id = NarouAgent::UrlHelper.extract_part_id(narou_config['url'])
            url     = agent.update_part(ncode: ncode, part_id: part_id, subtitle: post['title'], body: post.output)
            Jekyll.logger.info 'Updated:', "#{post.basename} #{url}"
          else
            url = agent.create_part(ncode: ncode, subtitle: post['title'], body: post.output)
            Jekyll.logger.info 'Created:', "#{post.basename} #{url}"
            Util.append_yaml_front_matter post.path, <<~YAML
              narou:
                url: #{url}
            YAML
          end
        end
      end
    end
  end
end
