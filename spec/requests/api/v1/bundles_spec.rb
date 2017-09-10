RSpec.describe '/api/v1/bundles', type: :request do
  let(:bundle_attributes) do
    bundle_attrs = attributes_for(:bundle)
    items = bundle_attrs.delete(:items_json).map { |product, period| {product: product, period: period} }
    bundle_attrs.merge(items: items)
  end

  let(:bundle) { create(:bundle) }

  it 'lists bundles' do
    bundle = create(:bundle)
    get '/api/v1/bundles'
    expect(v1_response['data'][0]['id'].to_i).to eq(bundle.id)
  end

  it 'shows bundle' do
    get "/api/v1/bundles/#{bundle.id}"
    expect(v1_response['data']['id'].to_i).to eq(bundle.id)
  end

  it 'creates new bundle' do
    expect {
      v1_create Bundle, bundle_attributes
    }.to change { Bundle.count }.by(1)
  end

  it 'does not allow to create bundle with invalid product' do
    bundle_attributes[:items] << {product: 'unknown', period: 'year'}
    v1_create Bundle, bundle_attributes
    expect(response.status.to_i).to eq(400)
    expect(v1_response['errors'][0]['detail']).to match(/unknown is not a valid value for product/)
  end

  it 'updates bundle' do
    expect {
      v1_update(bundle, {name: 'new name'})
    }.to change { bundle.reload.name }.from(bundle.name).to('new name')
  end

  it 'allows to change item' do
    attributes = {items: [{product: 'math', period: 'year'}]}
    v1_update(bundle, attributes)
    expect(bundle.reload.items.count).to eq(1)
  end

  it 'deletes bundle' do
    expect {
      v1_delete(bundle)
    }.to change { Bundle.where(id: bundle.id).count }.from(1).to(0)
  end
end
