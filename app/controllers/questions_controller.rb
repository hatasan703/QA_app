class QuestionsController < ApplicationController

  impressionist actions: [:show]

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
          format.html { redirect_to root_path }
        else
          format.html { render :new }
        end
    end
  end

  def show
    @question = Question.find(params[:id])
    # impressionist(@question, nil, unique: [:session_hash])
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
    # binding.pry
  end

  def categories
    @categories = Category.all
  end

  def category
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: true)
  end

  def category_open
    @category = Category.find(params[:id])
    @all_questions = @category.questions.includes(:user)
    @questions = @all_questions.where(done: nil)
  end

  def ranking
  end

  def open
    @all_questions = Question.all
    @questions = @all_questions.where(done: nil)
  end

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
    # binding.pry
  end

  private
  def question_params
    params.require(:question).permit(:title, :text, :category_id).merge(user_id: current_user.id)
  end

  #前検索のパラメータ保持
  def set_prev_search_params
    prev_q = URI(request.referer).query
    prev_params = Rack::Utils.parse_nested_query(prev_q)
    params[:q] = prev_params['q']
  end

end
