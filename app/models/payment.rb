class Payment < ApplicationRecord
  belongs_to :student
  belongs_to :order

  def process
    if order
      if amount >= order.price
        transaction do
          order.update!(paid: true)
          update!(processed: true)
        end
      else
        raise RuntimeError
      end
    end
  end
end
