require 'application_system_test_case'

class UserIndexTest < ApplicationSystemTestCase
  test 'User index page displays the username of all other users' do
    visit users_path

    assert_text 'User 1'
    assert_text 'User 2'
  end

  test 'User index page displays the profile picture for each user' do
    visit users_path

    assert_selector "img[src*='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png']"
    assert_selector "img[src*='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png']"
  end

  test 'User index page displays the number of posts each user has written' do
    visit users_path

    assert_text 'Number of posts: 5'
    assert_text 'Number of posts: 10'
  end

  test 'User index page redirects to the user show page when a user link is clicked' do
    visit users_path

    user_link = first('.user-link')
    expected_url = user_path(user_link[:href][%r{/users/(\d+)}, 1])

    current_url

    user_link.click

    assert_no_text 'Loading...'

    assert_equal expected_url, URI.parse(current_url).path
  end
end
