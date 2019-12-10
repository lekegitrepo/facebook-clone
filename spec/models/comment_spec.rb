# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @user = User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe',
                     email: 'john@gmail.com', password: 'johndoe',
                     password_confirmation: 'johndoe')
    @user.save
    @post = @user.posts.create(content: 'Texting post is great')
    @post.save
    @comment = Comment.create(comment: 'comment for post', user: @user, post: @post)
  end

  it 'should be valid' do
    expect(@comment).to be_valid
  end

  it 'nil comment should not be valid' do
    comment = Comment.new(comment: nil)
    expect(comment).to_not be_valid
  end

  it 'empty comment should not be valid' do
    comment = Comment.new(comment: ' ')
    expect(comment).to_not be_valid
  end
end
