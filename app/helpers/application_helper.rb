module ApplicationHelper
  # returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  private

  # confirms the correct user.
  def authorize_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
