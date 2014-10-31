source 'https://rubygems.org'
ruby ENV['HEROKU_RUBY_VERSION'] if ENV['HEROKU_RUBY_VERSION']

gem 'rails', '4.1.7'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'twitter-bootstrap-rails'
gem 'haml-rails'
gem 'less-rails'
gem 'bootstrap-switch-rails'
gem 'font-awesome-sass'
gem 'schema_plus'
gem 'redis'
gem 'dotenv-rails'

gem 'devise'
gem 'omniauth-google-oauth2'
gem 'doorkeeper'

gem 'rest-client'
gem 'nokogiri'
gem 'kaminari'

gem 'google-webfonts-rails'
gem 'rack-google-analytics'
gem 'i18n-js'

gem 'meta-tags', require: 'meta_tags'
gem 'ikazuchi'

group :production do
  gem 'mysql2'
  gem 'unicorn'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rubocop'
  gem 'coveralls', require: false
end
