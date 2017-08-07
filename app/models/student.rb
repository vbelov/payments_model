class Student < ApplicationRecord
  def subscriptions
    premium_until.map do |product_code, premium_end_string|
      Subscription.new(
          student: self,
          product: Product.find_by_code!(product_code),
          end_date: premium_end_string.to_date
      )
    end
  end

  # noinspection RailsChecklist04
  def find_subscription(product)
    subscriptions.find { |s| s.product == product }
  end

  def apply_order(order)
    unless order.paid?
      transaction do
        order.bundle_items.each do |bundle_item|
          update_subscription(bundle_item)
        end
        premium_until_will_change!
        save!
        order.update!(paid: true)
      end
    end
  end

  private

  def update_subscription(bundle_item)
    product_code = bundle_item.product.code
    date = premium_until[product_code]&.to_date || Date.today
    new_date = bundle_item.subscription_period.from(date)
    self.premium_until[product_code] = new_date.to_s
  end
end
