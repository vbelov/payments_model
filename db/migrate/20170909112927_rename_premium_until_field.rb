class RenamePremiumUntilField < ActiveRecord::Migration[5.1]
  def change
    rename_column :students, :premium_until, :subscriptions_json
  end
end
