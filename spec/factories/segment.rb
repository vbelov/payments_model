FactoryGirl.define do
  factory :segment do
    region_ids { (1..10).to_a.shuffle.take(rand(11)) }
    payments { [-1, 0, 1].sample }
    b2what { ['b2c', 'b2t', nil].sample }
    levels { (0..9).to_a.shuffle.take(rand(11)) }
    trials_count { rand(10) }
  end
end
