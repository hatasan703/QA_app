class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  after_update :question_update


  private
  def question_update
    self.question.update(done: true)
  end

end
