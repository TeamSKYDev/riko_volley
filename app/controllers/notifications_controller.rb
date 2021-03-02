class NotificationsController < ApplicationController
  def update
    Notification.first.update(notification_params)
    redirect_back(fallback_rocation: root_path)
  end

  private
  def notification_params
    params.require(:notification).permit(:days_before)
  end
end
