class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @user = User.new
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @user.save!
    redirect_to users_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def check_admin
    unless current_user.is_admin == true
      redirect_to posts_path
    end
  end
end
