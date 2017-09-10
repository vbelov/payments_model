class SubscriptionPeriod
  attr_reader :code, :name

  class NotFound < RuntimeError
    attr_reader :period_code

    def initialize(message, code)
      super(message)
      @period_code = code
    end
  end

  def initialize(options)
    @code = options['code']
    @name = options['name']
  end

  class << self
    def all
      return @all if @all

      country_code = 'russia' # read from env
      hash = YAML.load_file("config/countries/#{country_code}/subscription_periods.yaml")
      @all = hash['subscription_periods'].map do |period_hash|
        handler = "subscription_periods/#{period_hash['handler']}_period".classify.constantize
        handler.new(period_hash)
      end
    end

    def find_by_code(code)
      all.find { |p| p.code == code.to_s }
    end

    def find_by_code!(code)
      find_by_code(code) || raise(NotFound.new("Subscription period with code #{code} not found", code))
    end
  end
end
