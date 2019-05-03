class AnswersController < ApplicationController

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create
    Answer.create(create_params)
    redirect_to controller: :questions, action: :show
  end

  private
  def create_params
    params.require(:answer).permit(:text).merge(question_id: params[:question_id], user_id: current_user.id)
  end

end
