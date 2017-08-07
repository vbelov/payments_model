FactoryGirl.define do
  factory :payment do
    student
    order
    amount { order.price }
  end
end
