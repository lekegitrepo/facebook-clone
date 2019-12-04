class PostsController < ApplicationController
  before_action :check_post, only: %i[edit destroy]


  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created successful!'
    else
      flash[:danger] = 'Unable to create your post'
    end
    redirect_to root_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post successful deleted'
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def check_post
    @post = Post.find(params[:id])
    return unless @post.nil?

    flash[:danger] = 'Post does not exist'
    redirect_to root_path
  end
end
