module Rack
  # Dead simple thread-safe Rate limiter
  class RateLimit
    attr_reader :app
    attr_reader :rule

    def initialize(app)
      @app = app
      @rule = YAML.load_file("#{Rails.root}/config/rate-limit.yml")[Rails.env]
    end

    def call(env)
      request = Rack::Request.new(env)
      throttled?(request) ? block_request(request) : app.call(env)
    end

    private

    def throttled?(request)
      REDIS.exists("throttled:#{request.ip}") ? true : request_logger(request)
    rescue
      Rails.logger.warn 'Rate-limit not applied. Redis is down!'
      false
    end

    def throttle(request)
      # Transaction as command may fail to be queued
      REDIS.multi do
        REDIS.set("throttled:#{request.ip}", true, ex: rule['timeframe'])
        REDIS.del(request.ip)
      end
    end

    def request_logger(request)
      # Reduce network RRT
      rate = REDIS.pipelined do
        REDIS.incr(request.ip)
        REDIS.expire(request.ip, rule['timeframe'])
        REDIS.get(request.ip)
      end.last.to_i

      if rate > rule['requests']
        throttle(request)
      else
        false
      end
    end

    def block_request(request)
      time_left = REDIS.ttl("throttled:#{request.ip}")

      [429, {}, ["Rate limit exceeded. Try again in #{time_left} seconds."]]
    end
  end
end
