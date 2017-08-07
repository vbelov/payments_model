module SubscriptionPeriods
  class UntilJunePeriod < SubscriptionPeriod
    def initialize(options)
      super
    end

    def from_now
      from(Date.today)
    end

    def from(date)
      today = Date.today
      end_of_period = Date.new(today.month > 5 ? today.year + 1 : today.year, 5, 31)
      [date, end_of_period].max
    end
  end
end
