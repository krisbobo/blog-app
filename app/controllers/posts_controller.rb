class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = User.find_by(id: params[:user_id])
    author_id = params[:author_id]
    @posts = @posts.where(author_id:) if author_id.present?
    @comments = @posts.map(&:recent_comments)
    render :index
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: params[:user_id])
    @comments = @post.recent_comments if @post
    if @post
      render :show
    else
      redirect_to posts_url
    end
  end
end
