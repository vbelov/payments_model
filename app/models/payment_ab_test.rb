class PaymentAbTest < AbTest
  has_many :offers

  def add_bundle(bundle, prices:)
    prices.each do |group, price|
      offers.create!(
          bundle: bundle,
          segment: segment,
          price: price,
          ab_group: group,
      )
    end
  end
end
