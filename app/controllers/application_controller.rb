class ApplicationController < ActionController::Base

  before_action :search, except: [:search_resolved, :search_open]

  def search
    @search = Question.ransack(params[:q])
    @all_search_questions = @search.result.page(params[:page])
    @search_questions = @all_search_questions.where(done: true)
    # binding.pry
  end

end
