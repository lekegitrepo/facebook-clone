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
  end

  scenario 'create valid post' do
    visit root_path
    fill_in 'post[content]', with: 'New post for test'
    click_button 'Share'

    expect(page).to have_content('New post for test')

    expect(page).to have_button('Share')
  end

  scenario 'delete a post', js: true do
    visit root_path
    fill_in 'post[content]', with: 'New post for test'
    click_button 'Share'

    expect(page).to have_content('New post for test')

    click_on 'delete'

    a = page.driver.browser.switch_to.alert
    expect(a.text).to have_content('Are you sure?')
    a.accept

    expect(page).to_not have_content('New post for test')
  end

  scenario 'edit post' do
    @post = @user.posts.create(content: 'New post for test')
    visit root_path
    expect(page).to have_content('New post for test')

    click_on 'edit'

    visit edit_post_path(@post)

    fill_in 'post[content]', with: 'Update new post for test'

    expect(page).to have_button('Update')

    click_button 'Update'
    visit root_path
    expect(page).to have_content('Update new post for test')
  end
end
