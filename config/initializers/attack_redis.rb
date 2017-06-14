# TODO: Redis Sentinels for failovers
REDIS = Redis.new(host: ENV['REDIS_ADDR'], port: 6379)
REDIS_CONNECTION = { host: ENV['REDIS_ADDR'], port: 6379 }.freeze
