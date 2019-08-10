class AddQuestionsDoneTime < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :done_date, :date
  end
end
