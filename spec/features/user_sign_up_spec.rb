# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user sign up', type: :feature do
  scenario 'valid user sign up' do
    visit '/users/sign_up'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Username', with: 'johndoe'
    fill_in 'Email', with: 'john@gmail.com'
    fill_in 'Password', with: 'johndoe'
    fill_in 'Password confirmation', with: 'johndoe'
    click_button 'Sign up'

    expect(page).to have_content('johndoe')
    expect(page).to have_content('Applications')
    expect(page).to have_content('Contents and Posts')
    expect(page).to have_content('Advertisements')

    expect(page).to have_button('Share')
  end

  scenario 'invalid user sign up' do
    visit '/users/sign_up'
    fill_in 'First name', with: ''
    fill_in 'Last name', with: 'Doe'
    fill_in 'Username', with: 'johndoe'
    fill_in 'Email', with: 'john@gmail.com'
    fill_in 'Password', with: 'johndoe'
    fill_in 'Password confirmation', with: 'johndoe'
    click_button 'Sign up'

    expect(page).to have_content('First name')
    expect(page).to have_content('Last name')
    expect(page).to have_content('Username')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Password confirmation')

    expect(page).to have_button('Sign up')
  end

  scenario 'invalid user sign up with mismatch password' do
    visit '/users/sign_up'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Username', with: 'johndoe'
    fill_in 'Email', with: 'john@gmail.com'
    fill_in 'Password', with: 'johndoe'
    fill_in 'Password confirmation', with: 'johndoe2443'
    click_button 'Sign up'

    expect(page).to have_content('First name')
    expect(page).to have_content('Last name')
    expect(page).to have_content('Username')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Password confirmation')

    expect(page).to have_button('Sign up')
  end

  scenario 'invalid user sign up with short password' do
    visit '/users/sign_up'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Username', with: 'johndoe'
    fill_in 'Email', with: 'john@gmail.com'
    fill_in 'Password', with: 'johnd'
    fill_in 'Password confirmation', with: 'johnd'
    click_button 'Sign up'

    expect(page).to have_content('First name')
    expect(page).to have_content('Last name')
    expect(page).to have_content('Username')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Password confirmation')

    expect(page).to have_button('Sign up')
  end
end
