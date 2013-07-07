module LifePlan
  class Application
    def redis
      return @redis if @redis and @redis.client.connected?
      @redis = Redis.new(:url => ENV['REDIS_URL']).tap{|r| r.client.connect}
    end
  end
end
