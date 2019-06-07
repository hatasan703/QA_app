class AnswersController < ApplicationController

  def confirm
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    render template: "questions/show" if @answer.invalid?
  end

  def create
    # binding.pry
    @answer = Answer.new(answer_params)
    @question = Question.find(@answer.question_id)
    respond_to do |format|
        if params[:back]
          @all_answers = @question.answers.includes(:user)
          @answers = @all_answers.where(best_answer: nil).order("created_at DESC")
          format.html { render template: "questions/show" }
        elsif @answer.save
          format.html { redirect_to root_path } #あとで直す
        else
          format.html { render template: "questions/show" }

        end
    end

  end

  def ba_confirm
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
    render template: "questions/show" if @answer.invalid?
  end

  def update
    answer = Answer.find(params[:id])
    answer.update(ba_params)
    redirect_to root_path
  end

  private
  def answer_params
    params.require(:answer).permit(:text).merge(question_id: params[:question_id], user_id: current_user.id)
  end

  def ba_params
    params.require(:answer).permit(:text, :best_answer).merge(question_id: params[:question_id], user_id: current_user.id)
  end

end
