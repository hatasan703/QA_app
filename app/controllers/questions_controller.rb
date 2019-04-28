class QuestionsController < ApplicationController

  def new
  end

  def create
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

end
