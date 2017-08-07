RSpec.describe SubscriptionPeriods::UntilJunePeriod, type: :model do
  let(:period) { SubscriptionPeriod.find_by_code(:until_june) }

  describe '#from_now' do
    it 'возвращает 31 мая' do
      today = Date.today
      expect(period.from_now).to eq(Date.new(today.month > 5 ? today.year + 1 : today.year, 5, 31))
    end
  end

  describe '#from' do
    let(:period_end) { Date.parse('2018-05-31') }

    context 'если запрошена дата до 31 мая' do
      it 'возвращает 31 мая' do
        date = Faker::Date.between(period_end - 1.year, period_end)
        expect(period.from(date)).to eq(period_end)
      end
    end

    context 'если запрошена дата после 31 мая' do
      it 'возвращает запрошенную дату' do
        date = Faker::Date.between(period_end + 1, period_end + 1.year)
        expect(period.from(date)).to eq(date)
      end
    end
  end
end
