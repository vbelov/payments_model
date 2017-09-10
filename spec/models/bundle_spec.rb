RSpec.describe Bundle, type: :model do
  describe '#add_item' do
    let(:bundle) { bundle = create(:bundle, items_json: {}) }
    let(:bundle_item) { build(:bundle_item) }

    it 'добавляет элемент, но не сохраняет бандл' do
      bundle.add_item(bundle_item.product.code, bundle_item.subscription_period.code)
      expect(bundle.items.first).to eq(bundle_item)
      expect(bundle.reload.items.count).to eq(0)
    end
  end

  describe '#add_item!' do
    let(:bundle) { bundle = create(:bundle, items_json: {}) }
    let(:bundle_item) { build(:bundle_item) }

    it 'добавляет элемент и сохраняет бандл' do
      bundle.add_item!(bundle_item.product.code, bundle_item.subscription_period.code)
      expect(bundle.reload.items.count).to eq(1)
      expect(bundle.items.first).to eq(bundle_item)
    end
  end

  describe '#set_items' do
    let(:bundle) { bundle = create(:bundle) }
    let(:bundle_items) { build_list(:bundle_item, 2) }

    it 'изменяет список элементов' do
      expect {
        bundle.set_items(bundle_items.map(&:to_h))
      }.to change { bundle.items.count }.from(1).to(2)
      expect(bundle.items).to match_array(bundle_items)
    end
  end

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
    let(:segment) { create(:simple_segment) }
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

    context 'если для сегмента студента есть постоянное предложение и AB-тестовое' do
      let(:student_within_segment) { create_matching_student(segment) }
      let(:price_a) { rand(1_000) }
      let(:price_b) { rand(1_000) }
      let!(:ab_test) do
        create(
            :payment_ab_test,
            segment: segment,
            groups_count: 2,
            bundles: {
                bundle => { a: price_a, b: price_b }
            }
        )
      end

      it 'возвращает AB-тестовое предложение' do
        best_offer = bundle.find_offer(student_within_segment)
        expect(best_offer.payment_ab_test).to eq(ab_test)
        expect(best_offer.price).to eq(price_a)
      end
    end
  end

  describe '#create_order' do
    let(:bundle) { create(:bundle) }
    let(:student) { create(:student) }
    let(:offer) { create(:offer, bundle: bundle) }

    it 'создает заказ на основании ценового предложения для данного ученика' do
      expect(bundle).to receive(:find_offer).and_return(offer)
      order = bundle.create_order(student)
      expect(order.student).to eq(student)
      expect(order.offer).to eq(offer)
      expect(order.price).to eq(offer.price)
    end
  end
end
