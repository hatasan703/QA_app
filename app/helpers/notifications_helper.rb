module NotificationsHelper

    def unchecked_notifications
        @notifications=current_user.passive_notifications.where(check: false)
    end
end
