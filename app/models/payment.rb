class Payment < ApplicationRecord
  belongs_to :student
  belongs_to :order

  def process
    if order
      if amount >= order.price
        transaction do
          student.apply_order(order)
          update!(processed: true)
        end
      else
        raise RuntimeError
      end
    end
  end
end
