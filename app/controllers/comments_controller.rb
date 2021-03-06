# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :check_comment, only: %i[edit update destroy]
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'Comment created!'
    else
      flash[:danger] = 'Comment not created!'
    end
    redirect_to root_path
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to root_path
  end

  private

  def check_comment
    @comment = Comment.find(params[:id])
    return unless @comment.nil?

    flash[:danger] = 'Post does not exist'
    redirect_to root_path
  end

  def comment_params
    params.require(:comment).permit(:comment, :post_id)
  end
end
