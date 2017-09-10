RSpec.describe BundleItem, type: :model do
  describe '#new' do
    let(:product) { Product.all.sample }
    let(:period) { SubscriptionPeriod.all.sample }
    let(:hash) { {product: product.code, period: period.code}.stringify_keys }

    it 'with codes' do
      check_bundle BundleItem.new(product.code, period.code)
    end

    it 'with objects' do
      check_bundle BundleItem.new(product, period)
    end

    it 'with hash' do
      check_bundle BundleItem.new(hash)
    end

    def check_bundle(bundle)
      expect(bundle.product).to eq(product)
      expect(bundle.subscription_period).to eq(period)
    end
  end
end
