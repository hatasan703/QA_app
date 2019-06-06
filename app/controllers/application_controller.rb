class ApplicationController < ActionController::Base

  before_action :search

  def search
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
  end

end
