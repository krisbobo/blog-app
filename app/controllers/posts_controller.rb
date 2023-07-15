class PostsController < ApplicationController
  def index
    @posts = Post.all.includes(comments: :author)
    @user = User.find_by(id: params[:user_id])
    @posts = @posts.where(author_id: @user.id) if @user.present?
    render :index
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: params[:user_id])
    @comments = @post.recent_comments if @post
    @comment = Comment.where(post_id: params[:id])
    if @post
      render :show
    else
      redirect_to posts_url
    end
  end

  def new
    @user = @current_user
    @post = Post.new
    render :new
  end

  def create
    @user = @current_user
    @post = Post.new(post_params)
    @post.author_id = @user.id

    if @post.save
      flash[:success] = 'Post successfully created'
      redirect_to user_posts_url(@post.author_id)
    else
      flash[:alert] = 'Post could not be created'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text).merge(author_id: @user.id)
  end
end
