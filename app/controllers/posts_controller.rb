class PostsController < ApplicationController
  include Pagy::Backend

  before_action :check_sign_in, only: %i[create destory]
  before_action :set_posts,     only: %i[index]
  before_action :set_post,      only: %i[index destroy]

  def index
    # @post = Post.new
    @post.exercises.build
    @place = Place.new
    @places = Place.order(:position)
    @notification = Notification.first
  end


  def create
    @post = Post.new(post_params)
    @post.save!
    redirect_to posts_path
  end

  def destroy
    if @post.destroy
      flash[:notice] = '投稿を削除しました。'
      redirect_to posts_path
    else
      flash[:error] = '投稿の削除に失敗しました。'
      redirect_to posts_path
    end
  end

  private
  def set_posts
    @pagy, @posts = pagy(Post.all.includes([:user, exercises: :place]).order(id: :desc), items: 5)
  end

  def set_post
    @post = Post.find_or_initialize_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id, exercises_attributes: [:id, :place_id, :started_at, :ended_at, :_destroy]).merge(user_id: current_user.id)
  end
end