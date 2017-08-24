class Offer < ApplicationRecord
  belongs_to :bundle
  belongs_to :segment, required: false
  belongs_to :payment_ab_test, required: false

  validates :price, presence: true
  with_options if: :test? do
    validates :segment, presence: true
    validates :ab_group, presence: true, inclusion: {in: ->(offer) { offer.payment_ab_test.groups } }
  end


  delegate :bundle_items, to: :bundle

  def matches?(student)
    segment.contains?(student) && (permanent? || student.ab_group(payment_ab_test) == ab_group)
  end

  def permanent?
    !test?
  end

  def test?
    !payment_ab_test.nil?
  end
end
