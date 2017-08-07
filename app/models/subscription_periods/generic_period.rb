module SubscriptionPeriods
  class GenericPeriod < SubscriptionPeriod
    attr_reader :days

    def initialize(options)
      @days = options['days']
      super
    end

    def from_now
      from(Date.today)
    end

    def from(date)
      date + days
    end
  end
end
