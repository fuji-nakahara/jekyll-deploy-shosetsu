# jekyll-deploy-shosetsu

Jekyll plugin that adds subcommands to deploy your posts to [Kakuyomu](https://kakuyomu.jp/) or [Narou](https://syosetu.com/).

This gem is build on [KakuyomuAgent](https://github.com/fuji-nakahara/kakuyomu_agent), [NarouAgent](https://github.com/fuji-nakahara/narou_agent) and [FujiMarkdown](https://github.com/fuji-nakahara/fuji_markdown).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jekyll-deploy-shosetsu', group: :jekyll_plugins
```

And then execute:

    $ bundle

## Usage

You can deploy your posts to Kakuyomu and Narou by the following commands:

    $ bundle exec jekyll deploy-kakuyomu --email YOUR_EMAIL --password YOUR_PASSWORD --work_id KAKUYOMU_WORK_ID
    $ bundle exec jekyll deploy-narou --id YOUR_ID --password YOUR_PASSWORD --ncode NCODE

You can also edit the deploy settings in `_config.yml`:

```yaml
kakuyomu:
  work_id: 1234567890123456789
  email: kakuyomu@example.com
  password: KAKUYOMU_PASSWORD
narou:
  ncode: N9999ZZ
  id: narou@example.com
  password: NAROU_PASSWORD
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fuji-nakahara/jekyll-deploy-shosetsu. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the jekyll-deploy-shosetsu project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fuji-nakahara/jekyll-deploy-shosetsu/blob/master/CODE_OF_CONDUCT.md).
