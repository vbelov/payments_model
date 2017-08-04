require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#all' do
    it 'возвращает список всех продуктов' do
      products = Product.all
      expect(products.count).to eq(4)
      expect(products.first).to be_an_instance_of(Product)
      expect(products.first.code).to eq('math')
    end
  end
end
