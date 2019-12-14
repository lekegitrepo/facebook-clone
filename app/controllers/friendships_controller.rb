# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :check_user

  def index
    @friends = current_user.friends
    @friend_request = current_user.friend_requests
  end

  def create
    new_friend = User.find(params[:user_id])
    current_user.send_request(new_friend)
    redirect_back(fallback_location: root_path)
  end

  def update
    my_friend = User.find(params[:user_id])
    current_user.confirm_friend(my_friend)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = User.find(params[:user_id])
    if user
      @unfriend = current_user.friend_requests.find { |friendship| friendship.friend == user }
      @unfriend.delete
    else
      @inverse = @friend__val = current_user.pending_friendships.find(params[:friendship_id])
      @inverse.delete
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def check_user
    @user = User.find_by(id: params[:user_id])
    return unless @user.nil?

    flash[:danger] = "Internal error: user doesn't exist"
    redirect_back(fallback_location: root_path)
  end
end
