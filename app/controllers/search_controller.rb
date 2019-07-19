class SearchController < ApplicationController


  # 回答受付中のソートページ
  def open
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: nil).page(params[:page]).per(10).order('created_at DESC')
    @open_question_count = @search_questions.where(done: nil).count
  end

  def open_pv
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: nil).page(params[:page]).per(10).order('impressions_count DESC')
    @open_question_count = @search_questions.where(done: nil).count
  end

  def open_point
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: nil).page(params[:page]).per(10).order('point DESC')
    @open_question_count = @search_questions.where(done: nil).count
  end

  # 解決済みのソートページ
  def resolved
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: true).page(params[:page]).per(10).order('created_at DESC')
    @question_count = @search_questions.where(done: true).count
  end

  def resolved_pv
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: true).page(params[:page]).per(10).order('impressions_count DESC')
    @question_count = @search_questions.where(done: true).count
  end

  def resolved_point
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: true).page(params[:page]).per(10).order('point DESC')
    @question_count = @search_questions.where(done: true).count
  end


  private

  def set_prev_search_params
    prev_q = URI(request.referer).query
    prev_params = Rack::Utils.parse_nested_query(prev_q)
    prev_params['q']['title_cont'] = prev_params['q'][':title_cont'] if prev_params['q'][':title_cont'].present?
    params[:q] = prev_params['q']
  end

end
