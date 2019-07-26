class TopController < ApplicationController

  def index
    @all_questions = Question.all
    @questions = @all_questions.where(done: nil).order('created_at DESC').limit(5)
    @categories = Category.all
    @ranking_questions = Question.where(done: true).order('impressions_count DESC').limit(3)
  end

end
