module Jekyll
  module Commands
    class DeployKakuyomu < Command
      KAKUYOMU_OPTIONS = %w[email password work_id]

      class << self
        def init_with_program(prog)
          prog.command(:'deploy-kakuyomu') do |c|
            c.syntax 'deploy-kakuyomu [options]'
            c.description 'Deploy posts to kakuyomu'
            c.alias :dk

            c.option 'config', '--config CONFIG_FILE[,CONFIG_FILE2,...]', Array, 'Custom configuration file'
            c.option 'verbose', '-V', '--verbose', 'Print verbose output.'

            c.option 'email', '--email EMAIL', 'Email of Kakuyomu account'
            c.option 'password', '--password PASSWORD', 'Password of Kakuyomu account'
            c.option 'work_id', '--work_id WORK_ID', Integer, 'The posts will be deployed into Kakuyomu work of WORK_ID'

            c.action do |_args, options|
              options['kakuyomu'] = {}
              KAKUYOMU_OPTIONS.each do |key|
                options['kakuyomu'][key] = options[key] unless options[key].nil?
              end

              process(options)
            end
          end
        end

        def process(options, deployer: JekyllDeployShosetsu::Deployers::Kakuyomu.new)
          # Adjust verbosity quickly
          Jekyll.logger.adjust_verbosity(options)

          options = configuration_from_options(options)

          # Rendering settings
          options['markdown']               = 'FujiMarkdown'
          options['FujiMarkdown']           ||= {}
          options['FujiMarkdown']['output'] = 'kakuyomu'
          Jekyll::Hooks.register :posts, :pre_render do |post, _payload|
            post.merge_data!('layout' => 'none')
          end

          site = Jekyll::Site.new(options)
          site.reset
          site.read

          deploy(site, options, deployer)
        end

        def deploy(site, options, deployer)
          t       = Time.now
          source  = options['source']
          work_id = options['kakuyomu']['work_id']

          Jekyll.logger.info 'Source:', source
          Jekyll.logger.info 'Work id:', work_id
          Jekyll.logger.info 'Deploying...'

          deployer.deploy(site)

          Jekyll.logger.info '', "done in #{(Time.now - t).round(3)} seconds."
        end
      end
    end
  end
end
