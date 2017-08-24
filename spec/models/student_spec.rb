RSpec.describe Student, type: :model do
  describe '#subscriptions' do
    let(:end_date) { 1.month.from_now.to_date }
    let(:student) { create(:student, premium_until: { math: end_date }) }

    it 'возвращает список подписок' do
      expect(student.subscriptions.count).to eq(1)
    end
  end

  describe '#find_subscription' do
    let(:end_date) { 1.month.from_now.to_date }
    let(:student) { create(:student, premium_until: { math: end_date }) }

    it 'возвращает подписку на запрошенный продукт' do
      subscription = student.find_subscription(math_product)
      expect(subscription).to be_an_instance_of(Subscription)
      expect(subscription.student).to eq(student)
      expect(subscription.product).to eq(math_product)
      expect(subscription.end_date).to eq(end_date)
    end

    it 'возвращает nil, если нет подписки на запрошенный продукт' do
      subscription = student.find_subscription(english_product)
      expect(subscription).to be_nil
    end
  end

  describe '#apply_order' do
    let(:bundle) do
      create(:bundle,
             name: 'Математика на год и игра "Счет на лету" в подарок',
             items_json: {
                 math: 'year',
                 count_on_the_fly: 'unlimited'
             })
    end
    let(:offer) { bundle.default_offer }
    let(:student) { create(:student) }
    let(:order) { create(:order, offer: offer, student: student) }

    it 'создает подписки на продукты из заказа' do
      student.apply_order(order)
      expect(student.subscriptions.count).to eq(2)

      s1 = student.subscriptions[0]
      expect(s1.product).to eq(math_product)
      expect(s1.end_date).to eq(Date.today + 366)

      s2 = student.subscriptions[1]
      expect(s2.product).to eq(count_on_the_fly)
      expect(s2.end_date).to eq(Date.new(2100, 1, 1))
    end
  end

  describe '#ab_group' do
    let(:ab_test) { create(:ab_test) }

    context 'если студент попадает в сегмент AB-теста' do
      let(:student) { create_matching_student(ab_test.segment) }

      it 'возвращает группу AB-теста' do
        expect(ab_test).to receive(:next_group).once.and_return('a')
        2.times { expect(student.ab_group(ab_test)).to eq('a') }
      end
    end

    context 'если студент не попадает в сегмент AB-теста' do
      let(:student) { create_non_matching_student(ab_test.segment) }

      it 'возвращает nil' do
        expect(ab_test).not_to receive(:next_group)
        expect(student.ab_group(ab_test)).to eq(nil)
      end
    end
  end
end
