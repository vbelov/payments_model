FactoryGirl.define do
  factory :offer do
    bundle
    association :segment, factory: :simple_segment
    price { rand(1_000) + 1 }
  end
end
