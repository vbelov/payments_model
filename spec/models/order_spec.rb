require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'копирует цену предложения при создании' do
    order = create(:order)
    expect(order.price).to eq(order.offer.price)
  end
end
