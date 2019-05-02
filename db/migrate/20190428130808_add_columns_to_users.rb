class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :nickname, :string
    add_column :users, :sex, :boolean
    add_column :users, :money, :integer
    add_column :users, :bio, :text
    add_column :users, :role, :string

  end
end
