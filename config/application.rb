# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PlayTogetherNext
  # Main application configuration class.
  #
  # This class is responsible for configuring the Rails application, including
  # loading defaults, autoload paths, and other global settings.
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

# In development mode, Rails does not automatically load these files,
# even on the first server start, because they are not explicitly referenced anywhere.
# However, Telegram commands must be registered dynamically
# (see Telegram::Commands::Base.command and Telegram::CommandHandler.register).
# If these classes are not loaded, the commands will not be registered,
# causing them to be unavailable.
#
# This ensures that all command files are loaded every time the code is reloaded,
# so they are always properly registered.
Rails.application.reloader.to_prepare do
  Dir[Rails.root.join('app/services/telegram/commands/*.rb')].each { |file| require_dependency file }
end
