class ApplicationController < ActionController::Base

  before_action :search, except: [:search_resolved, :search_open]

  def search
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: true).order('created_at DESC').limit(10)
    @question_count = @search_questions.where(done: true).count
  end


end
