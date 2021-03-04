class PostsController < ApplicationController
  include Pagy::Backend

  before_action :set_posts, only: %i[index]
  before_action :set_post,  only: %i[index]

  def index; end

  def create; end

  private
  def set_posts
    @pagy, @posts = pagy(Post.all.order(id: :desc), items: 5)
  end

  def set_post
    @post = Post.find_or_initialize_by(id: params[:id])
  end
end