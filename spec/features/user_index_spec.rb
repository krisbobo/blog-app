require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User index page', type: :feature do
  before do
    @user1 = User.create(name: 'User 1', photo: 'user1.jpg', posts_counter: 10)
    @user2 = User.create(name: 'User 2', photo: 'user2.jpg', posts_counter: 5)
  end

  it 'displays the username of all other users' do
    visit users_path

    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  it 'displays the profile picture for each user' do
    visit users_path

    expect(page).to have_selector("img[src*='user1.jpg']")
    expect(page).to have_selector("img[src*='user2.jpg']")
  end

  it 'displays the number of posts each user has written' do
    visit users_path

    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    expect(page).to have_content("Number of posts: #{@user2.posts_counter}")
  end

  it 'redirects to the user show page when a user link is clicked' do
    visit users_path

    first('.user-link').click

    expect(current_path).to eq(user_path(@user1))
  end
end
