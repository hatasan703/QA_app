class QuestionsOptionFix < ActiveRecord::Migration[5.2]
  def change
    change_column :questions, :title, :string, null: false
    change_column :questions, :text, :text, null: false
  end
end
