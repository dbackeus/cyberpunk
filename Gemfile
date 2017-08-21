source "https://rubygems.org"
ruby "2.4.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 4.2"

# Use SCSS for stylesheets
gem "sass-rails"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks"

# App gems
gem "mongoid"
gem "simple_form"
gem "httpi"
gem "devise"
gem "omniauth-google-oauth2"
gem "airbrake"
gem "newrelic_rpm"
gem "newrelic_moped"
gem "intercom-rails"

group :development, :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
end

group :production do
  # needed for heroku https://devcenter.heroku.com/articles/rails4
  gem "rails_12factor"
  gem "puma"
end
