# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  def friends
    friends = friendships.includes(:friend).where(confirmed: true).references(:users)
    friends.map(&:friend)
  end

  def pending_friends
    requests = friendships.includes(:friend).where(confirmed: false).references(:users)
    requests.map(&:friend)
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def send_request(friend)
    return if Friendship.exists?(user_id: id, friend_id: friend.id) || friend.id == id

    Friendship.create(user_id: id, friend_id: friend.id)
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendship.confirmed = true
    friendship.save

    friendships.create(friend_id: user.id, confirmed: true)
  end

  def friend?(user)
    friends.include?(user)
  end

  def friends_posts
    friend_ids = friends.map(&:id)
    Post.where('user_id IN (?) OR user_id=?', friend_ids, id)
  end
end
