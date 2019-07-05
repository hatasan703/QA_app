class NotificationsController < ApplicationController
    def index
        @all_notify=current_user.passive_notifications.page(params[:page]).per(10)
        @all_notify.where(check: false).each do |notification|
            notification.update_attributes(check: true)
          end
    end
end
