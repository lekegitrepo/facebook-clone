# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all.order('username DESC')
  end

  def show
    @user_profile = User.find(params[:id])
  end
end
