class Offer < ApplicationRecord
  belongs_to :bundle
  belongs_to :segment, required: false

  delegate :bundle_items, to: :bundle
end
