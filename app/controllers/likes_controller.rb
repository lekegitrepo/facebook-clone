# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :check_post

  def create
    @like = @post.likes.build(user: current_user)
    @like.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def check_post
    @post = Post.find(params[:post_id])
    return unless @post.nil?

    flash[:danger] = 'Post does not exist'
    redirect_to root_path
  end
end
