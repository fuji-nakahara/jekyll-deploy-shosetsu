require 'io/console'

require 'jekyll'

require 'jekyll-fuji_markdown'
require 'kakuyomu_client'

require_relative 'jekyll/commands/deploy_kakuyomu'
require_relative 'jekyll-deploy-shosetsu/deployers/kakuyomu'
require_relative 'jekyll-deploy-shosetsu/version'

module JekyllDeployShosetsu
  class Error < StandardError; end
end
