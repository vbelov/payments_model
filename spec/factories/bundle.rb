FactoryGirl.define do
  factory :bundle do
    transient do
      product do
        Product.all.select(&:subject).sample
      end

      period do
        SubscriptionPeriod.all.select { |p| p.is_a?(SubscriptionPeriods::GenericPeriod) }.sample
      end
    end

    name { "#{product.name} - #{period.name}" }
    items_json do
      {product.code => period.code}
    end
  end
end
