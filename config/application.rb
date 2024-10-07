require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module HostpitalManagmentApi
  class Application < Rails::Application
    config.time_zone = 'America/Guayaquil'
    config.load_defaults 7.1
    I18n.load_path += Dir[File.expand_path('config/locales') + '/*.yml']
    config.i18n.default_locale = :en
    config.autoload_lib(ignore: %w[assets tasks])
    config.api_only = true
  end
end
