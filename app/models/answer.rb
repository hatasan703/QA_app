class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :text, presence: true




   # 自分の回答がBAに選定されたとき通知メソッド
   def ba_create_notification_by(current_user)
    notification = current_user.active_notifications.new(
    answer_id:self.id,
    visited_id:self.user.id,
    action:"best_answer"
    )
    notification.save if notification.valid?
   end

end
