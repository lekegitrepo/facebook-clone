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
    expect(page).to have_content('Advertisements')

    expect(page).to have_button('Share')
  end
end
