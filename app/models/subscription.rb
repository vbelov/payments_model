class Subscription
  include Virtus.model

  attribute :student, Student
  attribute :product, Product
  attribute :end_date, Date
end
