# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user login', type: :feature do
  subject do
    User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe',
             email: 'john@gmail.com', password: 'johndoe',
             password_confirmation: 'johndoe')
  end

  before { subject.save }

  scenario 'valid user login' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'john@gmail.com'
    fill_in 'Password', with: 'johndoe'
    click_button 'Log in'

    expect(page).to have_content('johndoe')
    expect(page).to have_content('Applications')
    expect(page).to have_content('Contents and Posts')
    expect(page).to have_content('People you may know')

    expect(page).to have_button('Share')
  end

  scenario 'invalid user login' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'james@gmail.com'
    fill_in 'Password', with: 'johndoe'
    click_button 'Log in'

    expect(page).to have_content('Log in')
    expect(page).to have_content('Remember me')
    expect(page).to have_content('Sign up')
    expect(page).to have_content('Forgot your password?')

    expect(page).to have_button('Log in')
  end

  scenario 'invalid empty login' do
    visit '/users/sign_in'
    fill_in 'Email', with: ''
    fill_in 'Password', with: ' '
    click_button 'Log in'

    expect(page).to have_content('Log in')
    expect(page).to have_content('Remember me')
    expect(page).to have_content('Sign up')
    expect(page).to have_content('Forgot your password?')

    expect(page).to have_button('Log in')
  end
end
