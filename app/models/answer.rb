class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  # after_update :question_update


  # private
  # def question_update
  #   self.question.update(done: true)
  # end



  #   自分の質問に回答がついたとき
  def create_notification_by(current_user)
    notification=current_user.active_notifications.new(
    answer_id:self.id,
    visited_id:self.user.id,
    action:"answer"
    )
    notification.save if notification.valid?
  end


#   自分の回答がベストアンサーに選定されたとき
#   def ba_create_notification_by(current_user)
#     notification=current_user.active_notifications.new(
#     answer_id:self.id,
#     visited_id:self.user.id,
#     action:"best_answer"
#     )
#     notification.save if notification.valid?
# end

end
