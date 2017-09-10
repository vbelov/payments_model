RSpec.describe '/api/v1/products', type: :request do
  let(:product) { Product.all.sample }

  it 'lists products' do
    v1_list(Product)
    expect(v1_response['data'].count).to eq(Product.all.count)
  end

  it 'shows product' do
    v1_show(product)
    expect(v1_response['data']['attributes']['name']).to eq(product.name)
  end

  it 'does not allow to create new products' do
    expect {
      v1_create(Product, {code: 'new'})
    }.to raise_error(ActionController::RoutingError)
  end
end
