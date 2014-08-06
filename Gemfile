source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.4'

# Use sqlite3 as the database for Active Record
# gem 'sqlite3'

gem 'virtus'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem "language_list"

gem "draper"
gem "hesburgh_infrastructure", git: 'git@git.library.nd.edu:hesburgh_infrastructure'
gem "hesburgh_api", git: 'git@git.library.nd.edu:hesburgh_api'
# gem "hesburgh_api", path: '../hesburgh_api'

gem "hesburgh_errors", git: 'git@git.library.nd.edu:hesburgh_errors'

gem "rb-readline"

gem 'devise'
gem 'devise_cas_authenticatable'
gem 'faraday'
gem 'american_date'

gem 'mysql2'

# Server monitoring
gem 'newrelic_rpm'

gem 'hipchat'
# gem 'rack-mini-profiler'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end



# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development, :test do
  gem "debugger"
  gem "rspec-rails"
  gem "capybara"
  gem "factory_girl_rails", require: false
  gem "faker"

  gem "guard"
  gem "guard-bundler"
  gem "guard-coffeescript"
  gem "guard-rails"
  gem "guard-rspec"
  gem "guard-spork"
  gem "spork", "1.0.0rc4"
  gem "growl"
end

group :test do
  gem "webmock"
  gem "vcr"
end
