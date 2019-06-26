class QuestionsAddImpressions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :impressions_count, :integer, default: 0
  end
end
