# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  @user = User.create(first_name: 'John', last_name: 'Doe', username: 'johndoe',
                      email: 'john@gmail.com', password: 'johndoe',
                      password_confirmation: 'johndoe')
  @user.save
  @post = @user.posts.new(content: 'Texting post is great')

  it 'should be valid' do
    @like = Like.new(user: @user, post: @post)
    expect(@like).to be_truthy
  end

  it 'unlike should be invalid' do
    @like = Like.new(user: @user, post: @post)
    @like.destroy
    expect(@like).to_not be_valid
  end

  describe 'Associations' do
    it 'like belongs to user' do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end

    it 'like belongs to post' do
      assoc = described_class.reflect_on_association(:post)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
