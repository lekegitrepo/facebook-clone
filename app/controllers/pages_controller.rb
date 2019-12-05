# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @posts = current_user.posts.all.order('created_at DESC')
    @my_post = current_user.posts.build
  end

  def show
    @user_profile = current_user
  end
end
