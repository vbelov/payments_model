class BundleItem
  attr_reader :product
  attr_reader :subscription_period

  def initialize(product_code, period_code)
    @product = Product.find_by_code!(product_code)
    @subscription_period = SubscriptionPeriod.find_by_code!(period_code)
  end
end
