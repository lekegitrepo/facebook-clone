# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :feature do
  before :each do
    @first_user = User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe',
                           email: 'john@gmail.com', password: 'johndoe',
                           password_confirmation: 'johndoe')
    @first_user.save
    @second_user = User.new(first_name: 'Jane', last_name: 'Doe', username: 'janedoe',
                            email: 'jane@gmail.com', password: 'janedoe',
                            password_confirmation: 'janedoe')
    @second_user.save

    visit '/users/sign_in'
    fill_in 'Email', with: @first_user.email
    fill_in 'Password', with: @first_user.password
    click_button 'Log in'
    visit users_path
    click_button 'Add new friend'
    click_on 'Logout'
  end

  scenario 'successfully' do
    fill_in 'Email', with: @second_user.email
    fill_in 'Password', with: @second_user.password
    click_button('Log in')
    visit users_path
    click_button 'Accept'
    expect(page).to have_content("#{@first_user.username} is one of my friend")
  end
end
