class Post < ApplicationRecord
  belongs_to :user
  has_many :comment
  has_many :like
end
