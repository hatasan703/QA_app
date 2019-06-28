class SearchController < ApplicationController


  # 回答受付中のソートページ
  def open
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: nil).order('created_at DESC').limit(10)
    @open_question_count = @search_questions.where(done: nil).count
  end

  def open_pv
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: nil).order('impressions_count DESC').limit(10)
    @open_question_count = @search_questions.where(done: nil).count
  end

  def open_answer_count
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: nil).joins(:answers).group("question_id").order('count(question_id) desc').limit(10)
    @open_question_count = @search_questions.where(done: nil).count
  end

  def open_point
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: nil).order('point DESC').limit(10)
    @open_question_count = @search_questions.where(done: nil).count
  end

  # 解決済みのソートページ
  def resolved
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: true).order('created_at DESC').limit(10)
    @question_count = @search_questions.where(done: true).count
  end

  def resolved_pv
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: true).order('impressions_count DESC').limit(10)
    @question_count = @search_questions.where(done: true).count
  end

  def resolved_answer_count
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: true).joins(:answers).group("question_id").order('count(question_id) desc').limit(10)
    @question_count = @search_questions.where(done: true).count
  end

  def resolved_point
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: true).order('point DESC').limit(10)
    @question_count = @search_questions.where(done: true).count
  end


  private

  def set_prev_search_params
    prev_q = URI(request.referer).query
    prev_params = Rack::Utils.parse_nested_query(prev_q)
    prev_params['q']['title_cont'] = prev_params['q'][':title_cont'] if prev_params['q'][':title_cont'].present?
    params[:q] = prev_params['q']
    # binding.pry
  end

end
