class TopController < ApplicationController

  def index
    @all_questions = Question.all
    @questions = @all_questions.where(done: nil).order('updated_at DESC').limit(3)
    @categories = Category.all
    @ranking_questions = Question.order('impressions_count DESC').limit(3)



    # 自分の質問に回答がついてからベストアンサーを選ばずに５日経過した場合に一度のみ通知作成

	# if user_signed_in? && current_user.questions.present?
	  questions = Question.where(done: nil)
	  questions.each do |question|
      if question.notifications.where(action: "question_dead", question_id: question.id).empty?
        if question.answers.present? && (Time.now.to_i - question.answers.first.created_at.to_i) / 60 / 60 / 24 >= 5
          notification = question.user.active_notifications.new(
            question_id:question.id,
            visited_id:question.user.id,
            action:"question_dead"
            )
          notification.save if notification.valid?

        #   8日経過した場合はランダムでベストアンサーが選定される処理
        elsif question.answers.present? && (Time.now.to_i - question.answers.first.created_at.to_i) / 60 / 60 / 24 >= 8
          answer = question.answers.sample
          ba_user = User.find(answer.user_id)
          ba_user_point = (question.point) + (ba_user.money)
          answer.update(best_answer: true)
          ba_user.update(money: ba_user_point)
          question.update(done: true)
          answer.ba_create_notification_by(question.user)
        end

        # 運営からのお知らせが１週間経過後表示されなくなるように
        articles = Article.where(check: false)
        articles.each do |article|
          if (Time.now.to_i - article.created_at.to_i) / 60 / 60 / 24 >= 7
            article.update(check: true)
          end
        end
      end
    end
  end
end

