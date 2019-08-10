class UserRankingController < ApplicationController

    def week
        @users = User.all
        # @users.each do |user|
        #     @best_answers = user.answers.where(best_answer: true)
        #     @best_answers.each do |answer|
        #         if answer.question.done_date ==７日以内
        #             @my_point += answer.question.point
        #         end
        #     end
        # end
    end

    def month
    end

    def total
        @user = User.order("money DESC")
    end

end
