module TusurCdn
  class Consumer
    attr_accessor :key, :css, :template, :javascript, :settings, :data

    def initialize(key:)
      @key = key
    end

    def get_data
      consume_base
      result = Hashie::Mash.new METHOD_PREFIX.each_with_object({}){|mp, hash| hash[mp] = send "#{mp}"}
    end

    private

    def redis
      @@redis ||= Redis.new(url: Settings['redis.cdn'])
    end

    def consume_base
      METHOD_PREFIX.each do |method_prefix|
        result = send "consume_#{method_prefix}"
        unless result
          JSON.parse RestClient.post("#{Settings['profile.url']}/cdn/update", {key: key})
          result = send "consume_#{method_prefix}"
        end
      end
      result
    end

    def consume_css
      @css = redis.get "cdn:css:#{key}"
    end

    def consume_javascript
      @javascript = redis.get "cdn:javascript:#{key}"
    end

    def consume_template
      @template = redis.get "cdn:template:#{key}"
    end

    def consume_settings
      @settings = Hashie::Mash.new JSON.load(redis.get("cdn:settings:#{key}"))
    end
  end
end
