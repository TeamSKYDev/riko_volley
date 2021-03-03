class NotificationsController < ApplicationController

  def update
    @notification = Notification.first
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to root_path }
        format.js
      end
    end

  end

  private
  def notification_params
    params.require(:notification).permit(:days_before, :status)
  end
end
