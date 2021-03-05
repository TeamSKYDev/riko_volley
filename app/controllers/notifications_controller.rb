class NotificationsController < ApplicationController

  def update
    @notification = Notification.first
    if @notification.update(notification_params)
      flash[:notice] = "保存しました"
    end
    redirect_back(fallback_location: root_path)
  end

  private
  def notification_params
    params.require(:notification).permit(:days_before, :status)
  end
end
