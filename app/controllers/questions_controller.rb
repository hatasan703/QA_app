class QuestionsController < ApplicationController

  def new
    @question = Question.new
    @categories = Category.all
  end

  def confirm
    @question = Question.new(create_params)
    render :new if @question.invalid?
    # @categories = Category.all
  end

  # def back
  #   @question = Question.new(create_params)
  #   render :new
  # end

  def create
    @question = Question.new(create_params)
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
    @answers = @question.answers.includes(:user)
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
  def create_params
    params.require(:question).permit(:title, :text, :category_id).merge(user_id: current_user.id)
  end

end


