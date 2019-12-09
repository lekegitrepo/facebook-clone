class LikesController < ApplicationController

  private

  def check_post
    @post = Post.find(params[:post_id])
  end
end
