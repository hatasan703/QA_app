class QuestionsController < ApplicationController

  def new
    @question = Question.new
    @categories = Category.all
  end

  def create
    Question.create(create_params)
    redirect_to :root
  end

  # def show
  #   @question = Question.find(params[:id])
  # end

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


