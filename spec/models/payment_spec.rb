RSpec.describe Payment, type: :model do
  describe '#process' do
    let(:student) { create(:student) }
    let(:order) { create(:order, student: student) }
    let(:payment) { create(:payment, order: order) }

    it 'помечает платеж как обработанный' do
      payment.process
      expect(payment.processed?).to be true
    end

    it 'помечает заказ как оплаченный' do
      payment.process
      expect(order.paid?).to be true
    end

    it 'создает необходимые подписки' do
      expect(payment.student).to receive(:apply_order).with(order)
      payment.process
    end
  end
end
