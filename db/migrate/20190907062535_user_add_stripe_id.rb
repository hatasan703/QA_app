class UserAddStripeId < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :connect_id, :string
  end
end
