# TODO: Migrate to API Gateway solution and never never never perform rate-limit via rack/rails
class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::RedisStore.new(REDIS_CONNECTION)
  RULE = YAML.load_file("#{Rails.root}/config/rate-limit.yml")[Rails.env]

  raise 'rules missconfiguration' if RULE && RULE.empty?

  period = RULE['timeframe']

  throttle('rate_limit_home', limit: RULE['requests'], period: period, &:ip) if RULE['enabled']

  Rack::Attack.throttled_response = lambda do |env|
    cache_key = env['rack.attack.match_discriminator']
    REDIS.set(cache_key, Time.now.since(period), ex: period) unless REDIS.exists(cache_key)

    time_left = REDIS.ttl(cache_key)
    [ 429, {}, ["Rate limit exceeded. Try again in #{time_left} seconds."]]
  end
end
