class UsersController < ApplicationController
  before_action :set_user
  def show
    @user = User.find(current_user.id)
  end

  private

  def set_user
    @user = User.find(current_user.id) if User.find(current_user.id)
  end
end
