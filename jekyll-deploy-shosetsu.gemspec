
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-deploy-shosetsu/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-deploy-shosetsu'
  spec.version       = JekyllDeployShosetsu::VERSION
  spec.authors       = ['Fuji Nakahara']
  spec.email         = ['fujinakahara2032@gmail.com']

  spec.summary       = 'Jekyll plugin that adds command to deploy posts to Kakuyomu or Narou'
  spec.homepage      = 'https://github.com/fuji-nakahara/jekyll-deploy-shosetsu'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'jekyll', '>= 3.5', '< 5.0'

  spec.add_dependency 'jekyll-fuji_markdown', '~> 0.3'
  spec.add_dependency 'kakuyomu_agent', '~> 0.3'
  spec.add_dependency 'narou_agent', '~> 0.2'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'meowcop', '~> 2.0'
  spec.add_development_dependency 'pry', '>= 0.12'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
