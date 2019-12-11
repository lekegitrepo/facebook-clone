class FriendshipsController < ApplicationController
  before_action :check_user

  def index
    @friends = current_user.friends
  end

  def create
    new_friend = User.find(params[:id])
    current_user.send_request(new_friend)
    redirect_back(fallback_location: root_path)
  end

  def update
    my_friend = User.find(params[:id])
    current_user.confirm_friend(my_friend)
    redirect_back(fallback_location: root_path)
  end

  private

  def check_user
    @user = User.find_by(id: params[:id])
    return unless @user.nil?

    flash[:danger] = "Internal error: user doesn't exist"
    redirect_back(fallback_location: root_path)
  end
end
