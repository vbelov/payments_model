class BundleItem
  include Comparable

  attr_reader :product
  attr_reader :subscription_period

  def initialize(*args)
    product_or_code, period_or_code =
        if args.first.is_a?(Hash)
          hash = args.first.with_indifferent_access
          [hash[:product], hash[:period]]
        else
          args
        end

    @product = get_product(product_or_code)
    @subscription_period = get_period(period_or_code)
  end

  def <=>(other)
    res = product <=> other.product
    res == 0 ? subscription_period <=> other.subscription_period : res
  end

  def to_h
    {product: product.code, period: subscription_period.code}
  end

  private

  def get_product(product_or_code)
    product_or_code.is_a?(Product) ? product_or_code : Product.find_by_code!(product_or_code)
  end

  def get_period(period_or_code)
    period_or_code.is_a?(SubscriptionPeriod) ? period_or_code : SubscriptionPeriod.find_by_code!(period_or_code)
  end
end
