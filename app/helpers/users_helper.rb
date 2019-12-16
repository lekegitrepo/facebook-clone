# frozen_string_literal: true

module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: 'gravatar')
  end

  def gravatar_icon_for(user, options = { size: 20 })
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: 'gravatar')
  end

  def user_status(user)
    if current_user.friend?(user)
      "#{user.username} is one of my friend"
      button_to 'Unfriend', user_reject_request_path(user), method: :delete, class: 'btn btn-danger mb-2'
    elsif current_user.pending_friends.include?(user)
      button_to 'Cancel request', user_reject_request_path(user), method: :delete, class: 'btn btn-danger mb-2'
    else
      button_to 'Add new friend', user_friendships_path(user), class: 'btn btn-info mb-2'
    end
  end

  def request_status(user)
    if current_user.friend_requests.include?(user)
      render partial: 'shared/request_status', local: { user: user }
    end
  end
end
