class Bundle < ApplicationRecord
  has_many :offers

  def add_item(product, period)
    items_json[product.code] = period.code
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

  def permanent_offers
    offers.select(&:permanent?)
  end

  def test_offers
    offers.select(&:test?)
  end

  # noinspection RailsChecklist04
  def find_offer(student)
    offers_in_order = test_offers + permanent_offers.select(&:segment)
    offers_in_order.find { |o| o.matches?(student) } || default_offer
  end

  def create_order(student)
    offer = find_offer(student)
    Order.create!(offer: offer, student: student)
  end
end
