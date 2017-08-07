RSpec.describe SubscriptionPeriod, type: :model do
  describe '#all' do
    it 'возвращает список всех периодов подписки' do
      periods = SubscriptionPeriod.all
      expect(periods.count).to eq(5)
    end
  end

  describe '#find_by_code' do
    it 'возвращает объект SubscriptionPeriod' do
      period = SubscriptionPeriod.find_by_code(:month)
      expect(period).to be_an_instance_of(SubscriptionPeriods::GenericPeriod)
      expect(period.code).to eq('month')
      expect(period.name).to eq('Подписка на месяц')
      expect(period.days).to eq(31)
    end
  end
end
