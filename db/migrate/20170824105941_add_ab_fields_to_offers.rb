class AddAbFieldsToOffers < ActiveRecord::Migration[5.1]
  def change
    add_reference :offers, :payment_ab_test
    add_column :offers, :ab_group, :string
  end
end
