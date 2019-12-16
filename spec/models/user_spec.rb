# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe',
                     email: 'john01@gmail.com', password: 'johndoe',
                     password_confirmation: 'johndoe')
    @user.save
  end

  it 'should be valid' do
    expect(@user).to be_valid
  end

  it 'user with empty password should not be valid' do
    @user.password = ' '
    expect(@user).to_not be_valid
  end

  it 'user with empty last name should not be valid' do
    @user.last_name = ' '
    expect(@user).to_not be_valid
  end

  it 'user with email set to nil should not be valid' do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  describe 'Associations' do
    it 'user has many posts' do
      assoc = described_class.reflect_on_association(:posts)
      expect(assoc.macro).to eq :has_many
    end
  end
end
