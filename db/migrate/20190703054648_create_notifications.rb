class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
        t.integer :visiter_id
        t.integer :visited_id
        t.integer :answered_question_id
        t.integer :best_answer_id
        t.string :action
        t.boolean :check, default: false
        t.timestamps
    end
  end
end
