require 'rails_helper'

RSpec.describe Post, type: :model do
  post = nil
  subject do
    User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe',
             email: 'john@gmail.com', password: 'johndoe',
             password_confirmation: 'johndoe')
  end

  before { subject.save }

  before { post = subject.posts.create(content: 'This is a test post') }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'post with empty content should not be valid' do
    post.content = ' '
    expect(post).to_not be_valid
  end

  it 'create post without user should not be valid' do
    post = Post.new
    expect(post).to_not be_valid
  end

  describe 'Associations' do
    it 'post belongs to user' do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
