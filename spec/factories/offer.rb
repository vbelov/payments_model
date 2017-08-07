FactoryGirl.define do
  factory :offer do
    bundle
    segment
    price { rand(1_000) + 1 }
  end
end
