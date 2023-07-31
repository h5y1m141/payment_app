source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '7.0.6'

gem 'pg', '~> 1.1'
gem 'aasm'
gem 'after_commit_everywhere', '~> 1.0'
gem 'puma', '~> 5.0'
gem 'graphql'
gem 'graphql-batch'
# GraphQLでの処理と比較するためRESTfulなAPIを作るために以下導入
gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'grape-swagger-entity', '~> 0.3'
gem 'grape-swagger-rails'
gem 'redis'
gem 'stripe'
gem 'jwt'

gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'jbuilder', '~> 2.7'
gem 'pagy'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'administrate'
gem 'nokogiri', '1.13.8'
gem 'rbs', require: false
gem 'rbs_rails', require: false


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'katakata_irb'
  gem 'steep'
  gem 'graphiql-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0', require: false
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'brakeman'
  # OpenAPIのドキュメント生成のために導入
  gem 'r2-oas'
end

group :test do
  gem 'stripe-ruby-mock'
  gem 'webmock'
  gem 'database_cleaner-active_record'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
