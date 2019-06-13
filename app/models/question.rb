class Question < ApplicationRecord
  has_many :answers
  belongs_to :user
  belongs_to :category
  has_one :pv

#  @question.impressionist_count
#  @question.impressionist_count(:start_date=>"2011-01-01",:end_date=>"2011-01-05")
#  @question.impressionist_count(:start_date=>"2011-01-01")  #specify start date only, end date = now
  is_impressionable

  def self.ransackable_attributes(*)
    %w[title]
  end
end
