class Offer < ApplicationRecord
  belongs_to :bundle
  belongs_to :segment, required: false
end
