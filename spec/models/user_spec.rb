require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe',
                     email: 'john@gmail.com', password: 'johndoe')
  }

  before { subject.save }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should be valid' do
    subject.password = ' '
    expect(subject).to_not be_valid
  end

  it 'should be valid' do
    subject.last_name = ' '
    expect(subject).to_not be_valid
  end
end
