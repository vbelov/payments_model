RSpec.describe Product, type: :model do
  describe '#all' do
    it 'возвращает список всех продуктов' do
      products = Product.all
      expect(products.count).to eq(7)

      product = products.first
      expect(product).to be_an_instance_of(Product)
      expect(product.code).to eq('math')
      expect(product.subject_code).to eq('math')
    end
  end

  describe '#find_by_code' do
    it 'возвращает продукт по его коду' do
      product = Product.find_by_code('math')
      expect(product).to be_an_instance_of(Product)
      expect(product.code).to eq('math')
      expect(product.subject_code).to eq('math')
    end
  end

  describe '#subject' do
    it 'возвращает предмет, которому принадлежит продукт' do
      product = Product.find_by_code('math')
      expect(product.subject).to be_an_instance_of(Subject)
      expect(product.subject.code).to eq('math')
    end

    it 'возвращает nil, если это игра' do
      product = Product.find_by_code('chocolate')
      expect(product.subject).to be_nil
    end
  end
end
