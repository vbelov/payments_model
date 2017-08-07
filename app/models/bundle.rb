class Bundle < ApplicationRecord
  def items
    items_json.map do |product_code, period_code|
      BundleItem.new(product_code, period_code)
    end
  end
end
