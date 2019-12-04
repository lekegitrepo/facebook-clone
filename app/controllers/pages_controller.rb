class PagesController < ApplicationController
  
  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
    @user_profile = current_user
  end
end
