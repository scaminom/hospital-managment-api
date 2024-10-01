require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HostpitalManagmentApi
  class Application < Rails::Application
    config.exceptions_app = routes
    config.time_zone = 'America/Guayaquil'
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w[assets tasks])
    config.api_only = true
  end
end
