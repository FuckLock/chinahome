# @Author: baodongdong
# @Date:   2017-11-21T21:09:07+08:00
# @Last modified by:   baodongdong
# @Last modified time: 2017-11-23T21:15:04+08:00

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Chinahome
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Beijing'

    config.i18n.default_locale = 'zh-CN'

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
