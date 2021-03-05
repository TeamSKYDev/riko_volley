class NotificationsController < ApplicationController

  def update
    @notification = Notification.first
    @notification.update(notification_params)
    redirect_to root_path

  end

  private
  def notification_params
    params.require(:notification).permit(:days_before, :status)
  end
end
