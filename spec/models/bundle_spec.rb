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

  describe '#default_offer' do
    let(:bundle) { create(:bundle) }
    let!(:old_price) { bundle.price }
    let(:new_price) { rand(1_000) + 1 }

    it 'возвращает предложение по умолчанию, которое не имеет ограничения по сегменту' do
      offer = bundle.default_offer
      expect(offer.price).to eq(bundle.price)
      expect(offer.segment).to be_nil
    end

    it 'поддерживает цену в актуальном состоянии' do
      expect {
        bundle.update!(price: new_price)
      }.to change { bundle.default_offer.price }.from(old_price).to(new_price)
    end
  end

  describe '#find_offer' do
    let(:segment) { create(:segment) }
    let(:bundle) { create(:bundle) }
    let!(:offer) { create(:offer, bundle: bundle, segment: segment) }

    context 'если для сегмента студента есть предложение' do
      let(:matching_student) { create_matching_student(segment) }

      it 'возвращает это предложение' do
        best_offer = bundle.find_offer(matching_student)
        expect(best_offer).to eq(offer)
      end
    end

    context 'если для сегмента студента нет предложений' do
      let(:non_matching_student) { create_non_matching_student(segment) }

      it 'возвращает предложение по умолчанию' do
        best_offer = bundle.find_offer(non_matching_student)
        expect(best_offer).to eq(bundle.default_offer)
      end
    end
  end
end
