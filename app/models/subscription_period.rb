class SubscriptionPeriod
  attr_reader :code, :name

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
  end
end
