class Bundle < ApplicationRecord
  has_many :offers

  def add_item(product, period)
    items_json[product.code] = period.code
    items_json_will_change!
    save!
  end

  def items
    items_json.map do |product_code, period_code|
      BundleItem.new(product_code, period_code)
    end
  end
  alias_method :bundle_items, :items

  def default_offer
    offer = offers.create_with(price: price).find_or_create_by!(segment: nil)
    offer.update!(price: price) unless offer.price == price
    offer
  end

  # noinspection RailsChecklist04
  def find_offer(student)
    offers.select(&:segment).find { |o| o.segment.contains?(student) } || default_offer
  end

  def create_order(student)
    offer = find_offer(student)
    Order.create!(offer: offer, student: student)
  end
end
