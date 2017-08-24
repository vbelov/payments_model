FactoryGirl.define do
  factory :payment_ab_test do
    association :segment, factory: :simple_segment
    groups_count 2

    transient do
      bundles Hash.new
    end

    after(:create) do |ab_test, evaluator|
      evaluator.bundles.each do |bundle, prices|
        ab_test.add_bundle(bundle, prices: prices)
      end
    end
  end
end
