require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuración para la localización por defecto en español
    config.i18n.available_locales = [:en, :es]
    config.i18n.default_locale = :es

    # Configuración para cargar traducciones desde el directorio locales
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]

    # Cargar el middleware personalizado para la funcionalidad multitenant
    config.eager_load_paths << Rails.root.join("app/middleware")
    #config.middleware.use ::TenantMiddleware


    # Configuration for the application, engines, and railties goes here.
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
