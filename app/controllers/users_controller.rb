class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_user, only: [:index, :destroy]
  before_action :set_users, only: [:index]

  def index; end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "登録完了"
      redirect_to users_path
    else
      set_users
      render "index"
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = "削除しました"
    end
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

  def set_user
    @user = User.find_or_initialize_by(id: params[:id])
  end
  def set_users
    @users = User.all
  end
end
