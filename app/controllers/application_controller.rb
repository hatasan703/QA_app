class ApplicationController < ActionController::Base

  before_action :search, except: [:search_resolved, :search_open]
  before_action :unchecked_notifications, :controller_action_logic

  def search
    @search = ::Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = @search_questions.where(done: true).order('updated_at DESC').limit(10)
    @question_count = @search_questions.where(done: true).count
  end

  def redirect_top
    redirect_to controller: :top, action: :index unless user_signed_in?
  end

  def unchecked_notifications
    if user_signed_in?
     @notifications = current_user.passive_notifications.where(check: false).order("created_at DESC").limit(3)
    end
     @unchecked_articles = Article.where(check: false).order("created_at DESC")
  end

  def controller_action_logic
    @question_new = params[:controller] == 'questions' && params[:action] == 'new'
    @question_confirm = params[:controller] == 'questions' && params[:action] == 'confirm'
    @top_index = params[:controller] == "top" && params[:action] == "index"
  end

end
