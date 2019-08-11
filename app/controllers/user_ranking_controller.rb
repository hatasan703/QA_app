class UserRankingController < ApplicationController

    def week
    end

    def month
    end

    def total
        @user = User.order("money DESC")
    end

end
