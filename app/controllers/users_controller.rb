class UsersController < ApplicationController
  def index
    @users = User.all.order('username DESC')
  end

  def show
    @user_profile = current_user
  end
end
