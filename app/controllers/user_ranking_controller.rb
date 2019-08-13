class UserRankingController < ApplicationController

    def week
        questions = Question.where(done: true)
        weekly_question = []
        questions.each do |question|
            if (Time.now.to_i - question.done_date.to_i) / 60 / 60 / 24 <= 7
                weekly_question << question
            end
        end
        @user_point = {}
        weekly_question.each do |question|
            user_id = question.user_id
            point = question.point

            if @user_point[user_id]
                @user_point[user_id] += point
            else
                @user_point[user_id] = point
            end
        end
        @user_point = Hash[ @user_point.sort_by{ |_, v| -v } ]
        @user_point = Hash[@user_point.keys.take(5).map{|k| [k, @user_point[k]] }.flatten(0)]
        @user_rank = [1, 2, 3, 4, 5]
    end

    def month
        questions = Question.where(done: true)
        weekly_question = []
        questions.each do |question|
            if (Time.now.to_i - question.done_date.to_i) / 60 / 60 / 24 <= 30
                weekly_question << question
            end
        end
        @user_point = {}
        weekly_question.each do |question|
            user_id = question.user_id
            point = question.point

            if @user_point[user_id]
                @user_point[user_id] += point
            else
                @user_point[user_id] = point
            end
        end
        @user_point = Hash[ @user_point.sort_by{ |_, v| -v } ]
        @user_point = Hash[@user_point.keys.take(5).map{|k| [k, @user_point[k]] }.flatten(0)]
        @user_rank = [1, 2, 3, 4, 5]
    end

    def total
        questions = Question.where(done: true)
        @user_point = {}
        questions.each do |question|
            user_id = question.user_id
            point = question.point

            if @user_point[user_id]
                @user_point[user_id] += point
            else
                @user_point[user_id] = point
            end
        end
        @user_point = Hash[ @user_point.sort_by{ |_, v| -v } ]
        @user_point = Hash[@user_point.keys.take(5).map{|k| [k, @user_point[k]] }.flatten(0)]
        @user_rank = [1, 2, 3, 4, 5]
    end

end

# ①カラム変更
# dateではなくtimeに
