RSpec.describe '/api/v1/subscription_periods', type: :request do
  let(:period) { SubscriptionPeriod.all.sample }

  it 'lists periods' do
    v1_list(SubscriptionPeriod)
    expect(v1_response['data'].count).to eq(SubscriptionPeriod.all.count)
  end

  it 'shows period' do
    v1_show(period)
    expect(v1_response['data']['attributes']['name']).to eq(period.name)
  end

  it 'does not allow to create new period' do
    expect {
      v1_create(SubscriptionPeriod, {code: 'new'})
    }.to raise_error(ActionController::RoutingError)
  end
end
