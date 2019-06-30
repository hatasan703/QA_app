class UserMoneyDefault < ActiveRecord::Migration[5.2]
    def change
        change_column :users, :money, :integer, default: 0
    end
end
