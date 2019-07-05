module NotificationsHelper

    def unchecked_notice_count
        current_user.passive_notifications.where(check: false).count
    end
end


