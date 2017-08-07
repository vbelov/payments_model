module HelperMethods
  def math_product
    Product.find_by_code('math')
  end

  def count_on_the_fly
    Product.find_by_code('count_on_the_fly')
  end

  def year_period
    SubscriptionPeriod.find_by_code('year')
  end

  def unlimited_period
    SubscriptionPeriod.find_by_code('unlimited')
  end
end

RSpec.configure do |c|
  c.include HelperMethods
end
