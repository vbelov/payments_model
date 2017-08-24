RSpec.describe PaymentAbTest, type: :model do
  let(:ab_test) { create(:payment_ab_test, groups_count: 2) }
  let(:bundle) { create(:bundle) }
  let(:price_a) { rand(1_000) }
  let(:price_b) { rand(1_000) }

  describe '#add_bundle' do
    it 'создает соответствующие объекты Offer' do
      ab_test.add_bundle(bundle, prices: {a: price_a, b: price_b})
      expect(ab_test.offers.count).to eq(2)

      offer = ab_test.offers.first
      expect(offer.segment).to eq(ab_test.segment)
      expect(offer.bundle).to eq(bundle)
      expect(offer.ab_group).to eq('a')
      expect(offer.price).to eq(price_a)
    end
  end
end
