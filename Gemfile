source 'https://rubygems.org'
ruby '2.3.1'

# http://stackoverflow.com/a/35893625/1577357
gem 'rake', '< 11.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'carrierwave', '~> 1.0'
gem 'httparty', '~> 0.14.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'bootstrap-sass', '~> 3.1.1'

group :development, :test do
  gem 'spring', '~> 2.0', '>= 2.0.1'
  gem "byebug"
  gem "rspec-rails", "~> 3.1.0"
  gem "factory_girl_rails", "~> 4.4.1"
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3'
  gem 'spring-commands-rspec', '~> 1.0', '>= 1.0.4'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.1'
  gem "faker", "~> 1.4.3"
  gem "capybara"
  gem 'capybara-webkit'
  gem "database_cleaner", "~> 1.3.0"
  gem "launchy", "~> 2.4.2"
  gem 'selenium-webdriver'
  gem 'email_spec', '~> 2.1'
  gem 'timecop', '~> 0.8.1'
  gem 'vcr', '~> 3.0', '>= 3.0.3'
  gem 'webmock', '~> 2.3', '>= 2.3.2'
end

