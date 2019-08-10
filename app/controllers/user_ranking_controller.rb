class UserRankingController < ApplicationController

    def week
        questions = Question.where(done: true)
        weekly_question = []
        questions.each do |question|
            if (Date.today.to_i - question.done_date) / 60 / 60 / 24 <= 7
                weekly_question << question
            end
        end
        user_point = {}
        weekly_question.each do |question|
            # user_id = question.user_id
            # point = question.point
            user_point.merge!(question.user_id => question.point)
        end
        binding.pry
    end

    def month
    end

    def total
        @user = User.order("money DESC")
    end

end
