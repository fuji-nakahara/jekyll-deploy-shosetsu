require "fileutils"

require "bundler/setup"
require "jekyll-deploy-shosetsu"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  FIXTURE_DIR = File.expand_path('fixtures', __dir__)
  SOURCE_DIR = File.expand_path('source', __dir__)

  def reset_source_dir
    FileUtils.copy_entry(FIXTURE_DIR, SOURCE_DIR, remove_destination: true)
  end

  def source_dir(*files)
    File.join(SOURCE_DIR, *files)
  end
end
