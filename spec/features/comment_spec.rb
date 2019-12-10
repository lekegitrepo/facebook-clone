# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create post', type: :feature do
  before :each do
    @user = User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe',
                     email: 'john@gmail.com', password: 'johndoe',
                     password_confirmation: 'johndoe')
    @user.save
    visit '/users/sign_in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    visit root_path
    fill_in 'post[content]', with: 'New post for test'
    click_button 'Share'
  end

  scenario 'create valid comment for a post' do
    expect(page).to have_content('New post for test')

    expect(page).to have_content('0 comments')
    fill_in('comment[comment]', with: 'great new post', match: :first)
    click_button 'comment', match: :first
    expect(page).to have_content('great new post')
    expect(page).to have_content('1 comment')
  end

  scenario 'create invalid comment for a post' do
    expect(page).to have_content('New post for test')

    expect(page).to have_content('0 comments')
    fill_in('comment[comment]', with: ' ', match: :first)
    click_button 'comment', match: :first
    expect(page).to have_content('0 comments')
  end
end
