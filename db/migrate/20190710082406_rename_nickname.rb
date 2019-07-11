class RenameNickname < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :nickname, :user_name
  end
end
