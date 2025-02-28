class PostsController < ApplicationController
  include Pagy::Backend

  before_action :check_sign_in,          only: %i[create edit update destory]
  before_action :set_post,               only: %i[index destroy edit update]
  before_action :check_user,             only: %i[edit update]
  before_action :set_posts,              only: %i[index]
  before_action :set_place_notification, only: %i[index edit]

  def index; end

  def create
    @post = Post.new(post_params)
    ActiveRecord::Base.no_touching do
      if @post.save
        flash[:notice] = "投稿完了"
        message = {
          type: 'text',
          text: @post.create_message
        }
        client.broadcast(message)
        redirect_to posts_path
      else
        set_place_notification
        set_posts
        render "index"
      end
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = '削除完了'
    else
      flash[:error] = 'エラー'
    end
    redirect_to posts_path
  end

  def edit; end

  def update
    past_title = @post.title
    if @post.update(post_params)
      flash[:notice] = "編集完了"
      message = {
        type: 'text',
        text: @post.edit_message(past_title)
      }
      client.broadcast(message)
      redirect_to posts_path
    else
      set_place_notification
      set_posts
      render "edit"
    end
  end


  private
  def set_posts
    @pagy, @posts = pagy(Post.all.includes([:exercises, :user]).order(id: :desc), items: 5)
  end

  def set_post
    @post = Post.find_or_initialize_by(id: params[:id])

    # 初期値設定
    started_at = Time.zone.parse(Date.current.next_month.beginning_of_month.to_s + " 18:00:00").to_datetime
    ended_at = Time.zone.parse("21:00:00")
    # cocoonで使用
    @wrap_obj = Proc.new { |exercise| exercise.started_at = started_at; exercise.ended_at = ended_at; exercise }

    if @post.id.blank?
      @post.exercises.build(started_at: started_at, ended_at: ended_at)
    end
  end

  def set_place_notification
    @place = Place.new
    @places = Place.order(:position)
    @notification = Notification.first
  end

  def check_user
    if current_user != @post.user
      redirect_to posts_path
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id, exercises_attributes: [:id, :place_name, :started_at, :ended_at, :_destroy]).merge(user_id: current_user.id)
  end
end
