# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create post', type: :feature do
  before :each do
    user = User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe',
                    email: 'john@gmail.com', password: 'johndoe',
                    password_confirmation: 'johndoe')
    user.save
    visit '/users/sign_in'
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'Log in'
  end

  # scenario 'valid user sign up' do
  #   visit '/users/sign_up'
  #   fill_in 'First name', with: 'John'
  #   fill_in 'Last name', with: 'Doe'
  #   fill_in 'Username', with: 'johndoe'
  #   fill_in 'Email', with: 'john@gmail.com'
  #   fill_in 'Password', with: 'johndoe'
  #   fill_in 'Password confirmation', with: 'johndoe'
  #   click_button 'Sign up'

  #   expect(page).to have_content('johndoe')
  #   expect(page).to have_content('Applications')
  #   expect(page).to have_content('Contents and Posts')
  #   expect(page).to have_content('Advertisements')

  #   expect(page).to have_button('Share')
  # end
end
