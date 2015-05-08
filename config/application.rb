require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CheersMail
  class Application < Rails::Application
    config.serve_static_assets = true
    config.assets.version = '1.1'
    config.action_mailer.default_url_options = { host: 'thatoneepisode.us' }
  end
end
