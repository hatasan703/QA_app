class NotifyColumnRename < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :answered_question_id, :question_id
    rename_column :notifications, :best_answer_id, :answer_id
  end
end
