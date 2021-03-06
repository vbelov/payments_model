class Order < ApplicationRecord
  belongs_to :offer
  belongs_to :student

  before_validation on: :create do
    self.price = offer.price
  end

  delegate :bundle, :bundle_items, to: :offer
end
