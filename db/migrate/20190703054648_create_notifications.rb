class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
        t.integer :visiter_id
        t.integer :visited_id
        t.integer :answer_id
        t.integer :ba_question_id
        t.integer :resolved_question_id
        t.string :action
        t.boolean :check, default: false
        t.timestamps
    end
  end
end
