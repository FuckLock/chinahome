Chinahome
--------

个人社区网站系统，基于 [Ruby China](https://ruby-china.org) 而来。

目前涉及到核心gem:

gem 'rails', '~> 5.0.5'

gem 'sass-rails', '~> 5.0'

gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'

gem 'jquery-rails'

gem 'turbolinks', '~> 5'

gem 'jbuilder', '~> 2.5'

gem 'bootstrap', '~> 4.0.0.beta2.1'

gem 'font-awesome-rails'

gem 'jquery-atwho-rails'

gem 'newrelic_rpm'

gem 'redcarpet'

gem 'pygments.rb'

gem 'carrierwave'

gem 'sidekiq'

gem 'pg'

gem 'pghero'

gem 'exception-track'

gem 'kaminari'

gem 'devise'

gem 'second_level_cache'

gem 'simple_form'

gem 'rails-settings-cached'

gem 'omniauth'

gem 'omniauth-github'

gem 'letter_avatar'

group :development, :test do

  gem 'byebug', platform: :mri

  gem 'rubocop', require: false

  gem 'rspec-rails'

  gem 'rails-controller-testing'

  gem 'factory_bot_rails'

  gem 'database_cleaner'

  gem 'capybara'

  gem 'simplecov'

end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

前端采用的技术:

bootstrap 4

font-awesome-rails

jquery

coffeescript

scss

数据库：

postgresql

登录涉及的技术:

devise

omniauth

omniauth-github(支持github登录)

Markdown:

redcarpet

pygments.rb

目前涉及到的缓存技术:

Fragment Cache

ETag

second_level_cache

localStorage

测试：

rspec

代码风格：

rubocop

此项目正在开发学习中
