class Notification < ApplicationRecord
    # default_scope->{order(created_at: :desc)}
    belongs_to :question, optional: true
    belongs_to :answer, optional: true

    def notify_checked
        @notifications=current_user.passive_notifications.page(params[:page]).per(10)
        @notifications.where(check: false).each do |notification|
            notification.update_attributes(check: true)
          end
    end
end
