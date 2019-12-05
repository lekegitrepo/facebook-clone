class PagesController < ApplicationController
  def index
    @posts = Post.all.order('created_at DESC')
    @my_post = current_user.posts.build
  end

  def show
    @user_profile = current_user
  end
end
