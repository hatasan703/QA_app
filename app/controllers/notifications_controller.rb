class NotificationsController < ApplicationController
    def notify
        @notifications = current_user.passive_notifications.limit(10)
        binding.pry
    end
end
