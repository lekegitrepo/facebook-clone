# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'like post', type: :feature do
  before :each do
    @user = User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe',
                     email: 'john@gmail.com', password: 'johndoe',
                     password_confirmation: 'johndoe')
    @user.save
    visit '/users/sign_in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  scenario 'create and like post' do
    visit root_path
    fill_in 'post[content]', with: 'New post for test'
    click_button 'Share'

    expect(page).to have_content('New post for test')

    expect(page).to have_content('Like')
    click_link('Like', match: :first)

    expect(page).to have_content('Unlike')
  end

  scenario 'create, like and unlike post' do
    visit root_path
    fill_in 'post[content]', with: 'New post for test'
    click_button 'Share'

    expect(page).to have_content('New post for test')

    expect(page).to have_content('Like')
    click_link('Like', match: :first)

    expect(page).to have_content('Unlike')
    click_link 'Unlike'
    expect(page).to have_content('Like')
  end
end
