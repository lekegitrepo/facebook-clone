class PagesController < ApplicationController
  def index
  end

  def show
    @user_profile = current_user
  end
end
