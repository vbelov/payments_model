require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe '#process' do
    let(:order) { create(:order) }
    let(:payment) { create(:payment, order: order) }

    it 'помечает платеж как обработанный' do
      payment.process
      expect(payment.processed?).to be true
    end

    it 'помечает заказ как оплаченный' do
      payment.process
      expect(order.paid?).to be true
    end
  end
end
