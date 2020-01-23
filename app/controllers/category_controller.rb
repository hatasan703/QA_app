class CategoryController < ApplicationController

  before_action :set_category, except: :index

  # 解決済み
  def index
    @categories = Category.all
  end

  def show
    @questions = @all_questions.where(done: true).page(params[:page]).per(10).order('updated_at DESC')
  end

  def pv
    @questions = @all_questions.where(done: true).page(params[:page]).per(10).order('impressions_count DESC')
  end

  def point
    @questions = @all_questions.where(done: true).page(params[:page]).per(10).order('point DESC')
  end


  # 回答受付中
  def open
    @questions = @all_questions.where(done: nil).page(params[:page]).per(10).order('updated_at DESC')
  end

  def open_pv
    @questions = @all_questions.where(done: nil).page(params[:page]).per(10).order('impressions_count DESC')
  end

  def open_point
    @questions = @all_questions.where(done: nil).page(params[:page]).per(10).order('point DESC')
  end

  private

  def set_category
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
  end

end
