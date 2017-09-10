FactoryGirl.define do
  factory :bundle_item do
    product do
      Product.all.select(&:subject).sample
    end

    subscription_period do
      SubscriptionPeriod.all.select { |p| p.is_a?(SubscriptionPeriods::GenericPeriod) }.sample
    end

    initialize_with do
      BundleItem.new(product, subscription_period)
    end
  end
end
