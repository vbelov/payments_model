FactoryGirl.define do
  factory :ab_test do
    association :segment, factory: :simple_segment
    groups_count 2
  end
end
