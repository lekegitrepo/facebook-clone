# frozen_string_literal: true

class CommentsController < ApplicationController
  validates :comment, presence: true

  def index
    @post = Post.find(params[:id])
    @comments = @post.comments.all.order('created_at DESC')
  end

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = current_user.comments.build(comment_params)
    redirect_to root_path if @comment.save
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = 'Comment is edited'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id)
  end
end
