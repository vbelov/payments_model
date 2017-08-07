FactoryGirl.define do
  factory :payment do
    order
    student { order.student }
    amount { order.price }
  end
end
