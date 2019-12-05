require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe',
             email: 'john@gmail.com', password: 'johndoe',
             password_confirmation: 'johndoe')
  end

  before { subject.save }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'user with empty password should not be valid' do
    subject.password = ' '
    expect(subject).to_not be_valid
  end

  it 'user with empty last name should not be valid' do
    subject.last_name = ' '
    expect(subject).to_not be_valid
  end

  it 'user with email set to nil should not be valid' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  describe 'Associations' do
    it 'user has many posts' do
      assoc = described_class.reflect_on_association(:posts)
      expect(assoc.macro).to eq :has_many
    end
  end
end
