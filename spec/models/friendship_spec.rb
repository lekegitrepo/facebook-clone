# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    @first_user = User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe',
                           email: 'john@gmail.com', password: 'johndoe',
                           password_confirmation: 'johndoe')
    @first_user.save
    @second_user = User.new(first_name: 'Jane', last_name: 'Doe', username: 'janedoe',
                            email: 'jane@gmail.com', password: 'janedoe',
                            password_confirmation: 'janedoe')
    @second_user.save
    @friends = Friendship.new(user_id: @first_user.id, friend_id: @second_user.id)
  end

  it 'create a valid friendship' do
    expect(@friends).to be_valid
  end

  it 'create an invalid friendship without a user' do
    @friends.user = nil
    expect(@friends).to_not be_valid
  end

  it 'create an invalid friendship without a friend' do
    @friends.friend = nil
    expect(@friends).to_not be_valid
  end

  describe 'Association' do
    it 'friendship belongs to user' do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
