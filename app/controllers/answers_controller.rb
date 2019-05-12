class AnswersController < ApplicationController

  def confirm
    @answer = Answer.new(answer_params)
    @question = Question.find(@answer.question_id)
    render template: "questions/show" if @answer.invalid?
  end

  def create
    @answer = Answer.new(answer_params)
    @question = Question.find(@answer.question_id)
    respond_to do |format|
        if params[:back]
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
    answer.update(answer_params)
    redirect_to root_path　#あとで直す
  end

  private
  def answer_params
    params.require(:answer).permit(:text, :best_answer).merge(question_id: params[:question_id], user_id: current_user.id)
  end

end
