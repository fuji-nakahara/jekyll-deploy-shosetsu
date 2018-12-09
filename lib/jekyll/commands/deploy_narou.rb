module Jekyll
  module Commands
    class DeployNarou < Command
      class << self
        COMMAND_OPTIONS = {
          'id'    => ['--id ID', 'ID of Narou account'],
          'password' => ['--password PASSWORD', 'Password of Narou account'],
          'ncode'  => ['--ncode NCODE', 'The posts will be deployed into NCODE syosetsu'],
        }

        def init_with_program(prog)
          prog.command(:'deploy-narou') do |c|
            c.syntax 'deploy-narou [options]'
            c.description 'Deploy posts to Narou'
            c.alias :dn

            c.option 'config', '--config CONFIG_FILE[,CONFIG_FILE2,...]', Array, 'Custom configuration file'
            c.option "future", "--future", "Publishes posts with a future date"
            c.option 'verbose', '-V', '--verbose', 'Print verbose output.'

            COMMAND_OPTIONS.each do |key, val|
              c.option key, *val
            end

            c.action do |_args, options|
              options['narou'] = {}
              COMMAND_OPTIONS.keys.each do |key|
                options['narou'][key] = options[key] unless options[key].nil?
              end

              process(options)
            end
          end
        end

        def process(options, deployer: JekyllDeployShosetsu::Deployers::Narou.new)
          Jekyll.logger.adjust_verbosity(options)

          site = Jekyll::Site.new(configure(options))
          site.reset
          site.read

          deployer.deploy(site)
        end

        private

        def configure(options)
          Jekyll::Hooks.register :posts, :pre_render do |post, _payload|
            post.merge_data!('layout' => 'none')
          end

          config = configuration_from_options(options)

          config['markdown']               = 'FujiMarkdown'
          config['FujiMarkdown']           ||= {}
          config['FujiMarkdown']['output'] = 'narou'

          config
        end
      end
    end
  end
end
