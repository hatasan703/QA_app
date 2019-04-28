class QuestionsController < ApplicationController

  def new
    @question = Question.new
  end

  def create
    Question.create(create_params)
    redirect_to :root
  end

  def categories
    @categories = Category.all
  end

  def category
    @category = Category.find(params[:id])
  end

  def ranking
  end

  def open
  end

  private
  def create_params
    params.require(:question).permit(:title, :text, :category_id).merge(user_id: current_user.id)
  end

end
