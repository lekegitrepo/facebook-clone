class Post < ApplicationRecord
  belongs_to :user
  has_many :comment
  has_many :like

  # default_scope -> { order(created_at: :desc) }

  validates :content, presence: true, length: { minimum: 6, maximum: 250 }
end
