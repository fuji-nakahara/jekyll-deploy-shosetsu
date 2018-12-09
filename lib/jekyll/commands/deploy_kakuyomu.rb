module Jekyll
  module Commands
    class DeployKakuyomu < Command
      class << self
        COMMAND_OPTIONS = {
          'email'    => ['--email EMAIL', 'Email of Kakuyomu account'],
          'password' => ['--password PASSWORD', 'Password of Kakuyomu account'],
          'work_id'  => ['--work_id WORK_ID', Integer, 'The posts will be deployed into Kakuyomu work of WORK_ID'],
        }

        def init_with_program(prog)
          prog.command(:'deploy-kakuyomu') do |c|
            c.syntax 'deploy-kakuyomu [options]'
            c.description 'Deploy posts to Kakuyomu'
            c.alias :dk

            c.option 'config', '--config CONFIG_FILE[,CONFIG_FILE2,...]', Array, 'Custom configuration file'
            c.option "future", "--future", "Publishes posts with a future date"
            c.option 'verbose', '-V', '--verbose', 'Print verbose output.'

            COMMAND_OPTIONS.each do |key, val|
              c.option key, *val
            end

            c.action do |_args, options|
              options['kakuyomu'] = {}
              COMMAND_OPTIONS.keys.each do |key|
                options['kakuyomu'][key] = options[key] unless options[key].nil?
              end

              process(options)
            end
          end
        end

        def process(options, deployer: JekyllDeployShosetsu::Deployers::Kakuyomu.new)
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
          config['FujiMarkdown']['output'] = 'kakuyomu'

          config
        end
      end
    end
  end
end
