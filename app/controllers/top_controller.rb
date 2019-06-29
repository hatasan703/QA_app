class TopController < ApplicationController

  def index
    @all_questions = Question.all
    @questions = @all_questions.where(done: nil).limit(3)
    @categories = Category.all

    @ranking_questions = Question.order('impressions_count DESC').limit(3)
  end

end
