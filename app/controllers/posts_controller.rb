# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :check_post, only: %i[edit update destroy]
  before_action :current_user_post, only: %i[edit update destroy]
  before_action :user_signed_in?, only: %i[create destroy edit update]

  def index
    @posts = current_user.posts.all.order('created_at DESC')
    @my_post = current_user.posts.build
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
    @my_post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    current_post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = 'Successful updated post'
      redirect_to root_path
    else
      flash[:warning] = 'Unable to update post, please try again'
      @my_post = current_post
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
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

  def current_user_post
    @post = current_user.posts.find(params[:id])
    redirect_to root_path if @post.nil?
  end
end
