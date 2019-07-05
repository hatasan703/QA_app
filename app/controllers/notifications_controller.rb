class NotificationsController < ApplicationController
    def notify
        # @notifications = current_user.passive_notifications.limit(10)
        @notifications=current_user.passive_notifications.page(params[:page]).per(10)
    end

    # def notify_checked
    #     @notifications=current_user.passive_notifications.page(params[:page]).per(10)
    #     @notifications.where(check: false).each do |notification|
    #         notification.update_attributes(check: true)
    #       end
    # end
end
