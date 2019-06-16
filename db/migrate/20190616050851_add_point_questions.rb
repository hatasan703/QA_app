class AddPointQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :point, :integer, null: false
  end
end
