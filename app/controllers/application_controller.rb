class ApplicationController < ActionController::Base

  before_action :search

  def search
    @search = Question.ransack(params[:q])
    @all_search_questions = @search.result.page(params[:page])
    @search_questions = @all_search_questions.where(done: true)
  end

end
