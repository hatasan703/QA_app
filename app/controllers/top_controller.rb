class TopController < ApplicationController

  def index
    @all_questions = Question.all
    @questions = @all_questions.where(done: nil).limit(3)
    @categories = Category.all
  end

end
