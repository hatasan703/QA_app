class AnswersController < ApplicationController

before_action :redirect_top

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
          format.html { redirect_to controller: 'questions', action: 'show', id: @answer.question_id }
        else
          format.html { render template: "questions/show" }

        end
    end

  end

  def destroy
    answer = Answer.find(params[:id])
    if answer.best_answer.nil?
      answer.destroy if answer.user_id == current_user.id
    end
    redirect_to controller: 'questions', action: 'show', id: answer.question_id
  end

  def ba_confirm
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
    render template: "questions/show" if @answer.invalid?
    # binding.pry
  end

  def update
    answer = Answer.find(params[:id])
    question = Question.find(answer.question_id)
    ba_user = User.find(answer.user_id)
    ba_user_point = (question.point) + (ba_user.money)

    respond_to do |format|
      if params[:back]
        format.html { redirect_to controller: 'questions', action: 'show', id: answer.question_id }
      elsif answer.update(ba_params)
        question.update(done: true)
        ba_user.update(money: ba_user_point)
        format.html { redirect_to controller: 'questions', action: 'show', id: answer.question_id }
      else
        format.html { render template: "questions/show" }
      end
    end

  end

  private
  def answer_params
    params.require(:answer).permit(:text, :best_answer).merge(question_id: params[:question_id], user_id: current_user.id)
  end

  def ba_params
    params.require(:answer).permit(:best_answer).merge(question_id: params[:question_id])
  end

end
