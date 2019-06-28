class QuestionsController < ApplicationController

  # impressionist actions: [:show]
  # impressionist :unique => [:questions, :show, :session_hash]
  impressionist :unique => [:session_hash]

  def new
    @question = Question.new
    @categories = Category.all
  end

  def confirm
    @question = Question.new(question_params)
    render :new if @question.invalid?
  end

  def create
    @question = Question.new(question_params)
    @categories = Category.all
    respond_to do |format|
        if params[:back]
          format.html { render :new }
        elsif @question.save
          format.html { redirect_to controller: 'questions', action: 'show', id: @question.id }
        else
          format.html { render :new }
        end
    end
  end

  def destroy
    question = Question.find(params[:id])
    @answers = question.answers.includes(:user)
    if @answers.empty?
      question.destroy if question.user_id == current_user.id
    end
    redirect_to root_path
  end

  def show
    @question = Question.find(params[:id])
    impressionist(@question, nil, :unique => [:session_hash])

    @answer = Answer.new
    @all_answers = @question.answers.includes(:user)
    @answers = @all_answers.where(best_answer: nil).order("created_at DESC")
    @best_answer = @all_answers.find_by(best_answer: true)

    @is_questioner = false
    @answerable = true # TODO: 変数名は後で直す
    if current_user != nil
      @is_questioner = current_user.id == @question.user_id
      @answerable  = @all_answers.exists?(user_id: current_user.id)
    end
    @resolved = @question.done.present?

  end


  # ランキング
  def ranking
    @questions = Question.where(done: true)
    @ranking_questions = @questions.order('impressions_count DESC').limit(10)
  end

  def ranking_open
    @questions = Question.where(done: nil)
    @ranking_questions = @questions.order('impressions_count DESC').limit(10)
  end

  # 回答受付中
  def open
    @questions = Question.where(done: nil).order('created_at DESC').limit(10)
  end

  def open_pv
    @questions = Question.where(done: nil).order('impressions_count DESC').limit(10)
  end

  def open_answer_count
    @questions = Question.where(done: nil).joins(:answers).group("question_id").order('count(question_id) desc').limit(10)
  end

  def open_point
    @questions = Question.where(done: nil).order('point DESC').limit(10)
  end


  # 検索
  def search_open
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @search_open_questions = @search_questions.where(done: nil)
  end

  def search_resolved
    set_prev_search_params
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @search_resolved_questions = @search_questions.where(done: true)
  end


  private
  def question_params
    params.require(:question).permit(:title, :text, :category_id, :point).merge(user_id: current_user.id)
  end

  # 前検索のパラメータ保持
  def set_prev_search_params
    prev_q = URI(request.referer).query
    prev_params = Rack::Utils.parse_nested_query(prev_q)
    prev_params['q']['title_cont'] = prev_params['q'][':title_cont'] if prev_params['q'][':title_cont'].present?
    params[:q] = prev_params['q']
    # binding.pry
  end

end
