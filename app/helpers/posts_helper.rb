# frozen_string_literal: true

module PostsHelper
  def like_unlike_post(post)
    if liked?(post)
      link_to content_tag(
        :i,
        nil,
        class: 'fa fa-thumbs-down'
      ), post_like_path(post.id, id: like_post(post).id), method: :delete
    else
      link_to content_tag(
        :i,
        nil,
        class: 'fa fa-thumbs-up'
      ), post_likes_path(post), method: :post
    end
  end
end
