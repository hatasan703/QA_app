class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :text, null: false
      t.boolean :best_answer
      t.references :question
      t.timestamps
    end
  end
end
