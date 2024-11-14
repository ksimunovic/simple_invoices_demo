source "https://rubygems.org"

gem "rails", "~> 7.2.1"
gem "propshaft"
gem "sqlite3", ">= 1.4"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "acts_as_paranoid"
gem "hotwire-rails"

group :development do
  gem "standard"
  gem "standard-rails"

  # Reduces boot times through caching; required in config/boot.rb
  gem "bootsnap", require: false
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "faker"
end
