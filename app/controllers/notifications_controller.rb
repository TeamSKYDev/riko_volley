class NotificationsController < ApplicationController

  before_action :check_sign_in,          only: %i[update]

  def update
    @notification = Notification.first
    if @notification.update(notification_params)
      flash[:notice] = "保存しました"
    else
      flash[:error] = "エラー"
    end
    redirect_back(fallback_location: root_path)
  end

  private
  def notification_params
    params.require(:notification).permit(:days_before, :status)
  end
end
