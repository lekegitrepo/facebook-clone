# frozen_string_literal: true

module LikesHelper
  def liked?(post)
    Like.where(post_id: post.id, user_id: current_user.id).present?
  end

  def like_post(post)
    Like.where(post_id: post.id, user_id: current_user.id).first
  end
end
