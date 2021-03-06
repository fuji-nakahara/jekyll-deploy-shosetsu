require 'io/console'

require 'jekyll'

require 'jekyll-fuji_markdown'
require 'kakuyomu_agent'
require 'narou_agent'

require_relative 'jekyll/commands/deploy_kakuyomu'
require_relative 'jekyll/commands/deploy_narou'

require_relative 'jekyll-deploy-shosetsu/util'
require_relative 'jekyll-deploy-shosetsu/version'

require_relative 'jekyll-deploy-shosetsu/deployers/kakuyomu'
require_relative 'jekyll-deploy-shosetsu/deployers/narou'
