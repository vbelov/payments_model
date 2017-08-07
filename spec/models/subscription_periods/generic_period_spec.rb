RSpec.describe SubscriptionPeriods::GenericPeriod, type: :model do
  let(:period) { SubscriptionPeriod.find_by_code(:month) }

  describe '#from_now' do
    it 'возвращает дату завершения периода, отсчитанную от текущего дня' do
      expect(period.from_now).to eq(Date.today + 31)
    end
  end

  describe '#from' do
    it 'возвращает дату завершения периода, отсчитанную от запрошенной даты' do
      date = Faker::Date.between(Date.today, 1.year.from_now)
      expect(period.from(date)).to eq(date + 31)
    end
  end
end
