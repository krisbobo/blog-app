require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_many(:likes).dependent(:destroy).with_foreign_key('author_id') }
    it { should have_many(:posts).dependent(:destroy).with_foreign_key('author_id') }
    it { should have_many(:comments).dependent(:destroy).with_foreign_key('author_id') }
  end

  describe '#recent_posts' do
    it 'returns the 3 most recent posts' do
      user = User.create!(name: 'David Okpah', posts_counter: 0)
      user.posts.create!(title: 'Post 1', text: 'This is the first post', comments_counter: 0, likes_counter: 0)
      post2 = user.posts.create!(title: 'Post 2', text: 'This is the second post', comments_counter: 0,
                                 likes_counter: 0)
      post3 = user.posts.create!(title: 'Post 3', text: 'This is the third post', comments_counter: 0, likes_counter: 0)
      post4 = user.posts.create!(title: 'Post 4', text: 'This is the fourth post', comments_counter: 0,
                                 likes_counter: 0)

      recent_posts = user.recent_posts

      expect(recent_posts.pluck(:id)).to eq([post4.id, post3.id, post2.id])
    end
  end
end
