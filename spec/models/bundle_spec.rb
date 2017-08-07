RSpec.describe Bundle, type: :model do
  describe '#items' do
    let(:bundle) do
      create(:bundle,
             name: 'Математика на год и игра "Счет на лету" в подарок',
             items_json: {
                 math: 'year',
                 count_on_the_fly: 'unlimited'
             })
    end

    it 'возвращает список компонент бандла' do
      item1 = bundle.items[0]
      expect(item1.product).to eq(math_product)
      expect(item1.subscription_period).to eq(year_period)

      item2 = bundle.items[0]
      expect(item2.product).to eq(math_product)
      expect(item2.subscription_period).to eq(year_period)
    end
  end
end
