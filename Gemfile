# frozen_string_literal: true

# This line specifies that the gems should be downloaded from the official RubyGems repository.
source 'https://rubygems.org'

# This gem is used for making HTTP requests in Ruby.
gem 'faraday'
# A documentation generation tool for Ruby code that simplifies the process of creating high-quality API documentation.
gem 'yard'

# These gems are used only in development environments.
group :development do
  # bundler-audit is used for checking for security vulnerabilities in dependencies.
  gem 'bundler-audit'
  # dotenv is used for loading environment variables from a .env file.
  gem 'dotenv'
  # pry is a powerful REPL (read-eval-print loop) for Ruby.
  gem 'pry'
  # rubocop is a code style checker and formatter for Ruby code.
  gem 'rubocop'
end

# These gems are used only in test environments.
group :test do
  # rspec is a popular testing framework for Ruby.
  gem 'rspec'
  # rubocop for the testing suite of rspec
  gem 'rubocop-rspec'
  # simplecov is used for code coverage analysis.
  gem 'simplecov'
  # vcr is used for recording and replaying HTTP interactions in tests.
  gem 'vcr'
  # webmock is used for stubbing HTTP requests in tests in conjunction with the vcr gem.
  gem 'webmock'
end
