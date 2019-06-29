class CategoryController < ApplicationController

  # 解決済み
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: true).order('created_at DESC').limit(10)
  end

  def pv
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: true).order('impressions_count DESC').limit(10)
  end

  def point
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: true).order('point DESC').limit(10)
  end


  # 回答受付中
  def open
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: nil).order('created_at DESC').limit(10)
  end

  def open_pv
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: nil).order('impressions_count DESC').limit(10)
  end

  def open_point
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: nil).order('point DESC').limit(10)
  end

end
