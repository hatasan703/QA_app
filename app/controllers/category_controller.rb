class CategoryController < ApplicationController

  # 解決済み
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: true).page(params[:page]).per(10).order('created_at DESC')
  end

  def pv
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: true).page(params[:page]).per(10).order('impressions_count DESC')
  end

  def point
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: true).page(params[:page]).per(10).order('point DESC')
  end


  # 回答受付中
  def open
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: nil).page(params[:page]).per(10).order('created_at DESC')
  end

  def open_pv
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: nil).page(params[:page]).per(10).order('impressions_count DESC')
  end

  def open_point
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: nil).page(params[:page]).per(10).order('point DESC')
  end

end
