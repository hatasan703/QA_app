class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  # after_update :question_update


  # private
  # def question_update
  #   self.question.update(done: true)

  #   @answer = Answer.find(params[:id])
  #   @question = Question.find(@answer.question_id)
  #   question_point = @question.point
  #   self.user.update(point: question_point)
  # end

end
