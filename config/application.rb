require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:application, *Rails.groups)

module Discover
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.


    additional_autoload_directories = [
      Rails.root.join('lib'),
      Rails.root.join('app', 'query'),
      Rails.root.join('app', 'decorators'),
      Rails.root.join('app', 'service'),
    ]
    additional_autoload_directories.each do |directory|
      config.autoload_paths += Dir[directory]
      config.autoload_paths += Dir[File.join(directory, '{**}')].find_all { |f| File.stat(f).directory? }
    end



    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
    # config.assets.precompile += %w( search.js )
    config.assets.precompile += %w(
      primo/ndu/index.js
      primo/malc/index.js
      primo/ndu/index.css
      primo/bci/index.css
      primo/hcc/index.css
      primo/smc/index.css
    )

    config.assets.initialize_on_precompile = false
  end
end
