class AnswersController < ApplicationController

  def create
    @answers = Answer.create(create_params)
    redirect_to "/questions/#{@answers.question.id}"
  end

  private
  def create_params
    params.require(:answer).permit(:text).merge(question_id: params[:question_id], user_id: current_user.id)
  end

end
