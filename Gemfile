source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.1'
gem 'sqlite3'
gem 'puma', '~> 3.9'
gem 'redis-rails', '~> 5'

gem 'dotenv'

group :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'fakeredis'
end

group :development do
  gem 'ruby_dep', '~> 1.3.1'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
