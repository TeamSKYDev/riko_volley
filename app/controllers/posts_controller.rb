class PostsController < ApplicationController

  before_action :set_posts, only: %i[index]
  before_action :set_post,  only: %i[index]

  def index; end

  def create; end

  private
  def set_posts
    @posts = Post.all
  end

  def set_post
    @post = Post.find_or_initialize_by(id: params[:id])
  end
end