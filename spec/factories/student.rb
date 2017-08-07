FactoryGirl.define do
  factory :student do
    region_id { (1..10).to_a.sample }
    b2what { %w(b2c b2t).sample }
    level { (0..9).to_a.sample }
  end
end
