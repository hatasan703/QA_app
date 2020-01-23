class AnswersController < ApplicationController

  protect_from_forgery except: :confirm
  before_action :redirect_top
  before_action :set_answer, only: [:destroy, :ba_confirm, :update]

  def confirm
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    redirect_to controller: 'questions', action: 'show', id: @question.id if @answer.text.empty?
  end

  def create
    @answer = Answer.new(answer_params)
    @question = Question.find(@answer.question_id)

    if params[:back]
      @all_answers = @question.answers.includes(:user)
      @answers = @all_answers.where(best_answer: nil).order("updated_at DESC")
      format.html { render template: "questions/show" }
    elsif @answer.save
      @question.answered_create_notification_by(current_user)
      redirect_to controller: 'questions', action: 'show', id: @answer.question_id
    else
      render template: "questions/show"
    end
  end

  def destroy
    if @answer.best_answer.nil?
      @answer.destroy if @answer.user_id == current_user.id
    end
    redirect_to controller: 'questions', action: 'show', id: @answer.question_id
  end

  def ba_confirm
    @question = Question.find(@answer.question_id)
    render template: "questions/show" if @answer.invalid?
  end

  def update
    question = Question.find(@answer.question_id)
    ba_user = User.find(@answer.user_id)
    ba_user_point = (question.point) + (ba_user.money)

    respond_to do |format|
      if params[:back]
        format.html { redirect_to controller: 'questions', action: 'show', id: @answer.question_id }
      elsif @answer.update(ba_params)
        now = Time.now
        question.update(done: true, done_date: now)
        ba_user.update(money: ba_user_point)
        @answer.ba_create_notification_by(current_user)
        format.html { redirect_to controller: 'questions', action: 'show', id: @answer.question_id }
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

  def set_answer
    @answer = Answer.find(params[:id])
  end

end
