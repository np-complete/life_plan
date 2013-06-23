module LifePlan
  class Application
    def redis
      @redis ||= Redis.new(:url => ENV['REDIS_URL'])
    end
  end
end
