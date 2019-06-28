class SearchController < ApplicationController

  def open
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: nil)
  end

  def resolved
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: true)
  end

  def set_prev_search_params
    prev_q = URI(request.referer).query
    prev_params = Rack::Utils.parse_nested_query(prev_q)
    prev_params['q']['title_cont'] = prev_params['q'][':title_cont'] if prev_params['q'][':title_cont'].present?
    params[:q] = prev_params['q']
    # binding.pry
  end

end
