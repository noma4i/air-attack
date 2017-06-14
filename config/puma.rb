# TODO: write production aware config
threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count

port        ENV.fetch('PORT') { 3000 }

environment ENV.fetch('RAILS_ENV') { 'development' }

begin
  REDIS.ping
rescue => e
  Rails.logger.fatal "\033[31mRedis has gone with message #{e.message}\033[0m"
  Rails.logger.fatal "\033[31mApplication is not going to RATE-LIMIT any request. Bar is open!\033[0m"
end

plugin :tmp_restart
