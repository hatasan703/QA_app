class QuestionsController < ApplicationController

  def new
    @question = Question.new
    @categories = Category.all
  end

  def confirm
    @question = Question.new(question_params)
    render :new if @question.invalid?
  end

  def create
    @question = Question.new(question_params)
    @categories = Category.all
    respond_to do |format|
        if params[:back]
          format.html { render :new }
        elsif @question.save
          format.html { redirect_to root_path }
        else
          format.html { render :new }
        end
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @all_answers = @question.answers.includes(:user)
    @answers = @all_answers.where(best_answer: nil)
    @best_answer = @all_answers.find_by(best_answer: true)

    @is_questioner = false
    @answerable = true # TODO: 変数名は後で直す
    if current_user != nil
      @is_questioner = current_user.id == @question.user_id
      @answerable  = @all_answers.exists?(user_id: current_user.id)
    end
    @resolved = @question.done.present?
    # binding.pry
  end

  def categories
    @categories = Category.all
  end

  def category
    @category = Category.find(params[:id])
    @questions = @category.questions.includes(:user)

  end

  def ranking
  end

  def open
    @questions = Question.all
  end

  private
  def question_params
    params.require(:question).permit(:title, :text, :category_id).merge(user_id: current_user.id)
  end

end
