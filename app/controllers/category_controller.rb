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

  def category_pv
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: true).order('impressions_count DESC').limit(10)
  end

  def category_answer_count
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: true).joins(:answers).group("question_id").order('count(question_id) desc').limit(10)
  end

  def category_point
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: true).order('point DESC').limit(10)
  end


  # 回答受付中
  def category_open
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: nil).order('created_at DESC').limit(10)
  end

  def open_pv
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: nil).order('impressions_count DESC').limit(10)
  end

  def open_answer_count
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: nil).joins(:answers).group("question_id").order('count(question_id) desc').limit(10)
  end

  def open_point
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: nil).order('point DESC').limit(10)
  end

end
