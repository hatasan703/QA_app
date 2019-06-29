class Question < ApplicationRecord
  has_many :answers
  belongs_to :user
  belongs_to :category
  has_one :pv

  is_impressionable counter_cache: true
#  @question.impressionist_count
#  @question.impressionist_count(:start_date=>"2011-01-01",:end_date=>"2011-01-05")
#  @question.impressionist_count(:start_date=>"2011-01-01")  #specify start date only, end date = now

  def self.ransackable_attributes(*)
    %w[title]
  end

  def question_id
    0
  end
end
