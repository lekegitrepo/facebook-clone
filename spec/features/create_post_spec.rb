# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create post', type: :feature do
  before :each do
    user = User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe',
                    email: 'john@gmail.com', password: 'johndoe',
                    password_confirmation: 'johndoe')
    user.save
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
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

    click_button 'OK'

    a = page.driver.browser.switch_to.alert
    a.text.should = 'Are you sure?'
    a.accept

    expect(page).to_not have_content('New post for test')
  end
end
