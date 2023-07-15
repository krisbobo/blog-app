require 'test_helper'

class PostIndexMyTest < ActionDispatch::IntegrationTest
  test 'displays user post index correctly' do
    user = users(:one)
    Post.create(title: 'Post 1', text: 'Post 5 text', comments_counter: 5, like_counter: 10, author: user)
    Post.create(title: 'Post 2', text: 'Post 12 text', comments_counter: 3, like_counter: 7, author: user)

    get user_posts_path(user)
    assert_response :success

    assert_select '.bttn_3', text: 'Pagination'
  end
end
