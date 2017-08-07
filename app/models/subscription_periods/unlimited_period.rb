module SubscriptionPeriods
  class UnlimitedPeriod < SubscriptionPeriod
    def initialize(options)
      super
    end

    def from_now
      from(Date.today)
    end

    def from(date)
      Date.new(2100, 1, 1)
    end
  end
end
