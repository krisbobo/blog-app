# test/integration/user_show_test.rb
require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest
  test 'displays user details correctly' do
    user = users(:one)
    Post.create(title: 'Post 1', text: 'Post 1 text', comments_counter: 5, likes_counter: 10, author: user)
    Post.create(title: 'Post 2', text: 'Post 2 text', comments_counter: 3, likes_counter: 7, author: user)
    Post.create(title: 'Post 3', text: 'Post 3 text', comments_counter: 2, likes_counter: 4, author: user)

    user.update(posts_counter: user.posts.count)

    get user_path(user)

    assert_response :success
    assert_select '#user-details'

    assert_select '.user-description' do
      assert_select '.img-div'
      assert_select "img[src*='#{user.photo}']"
      assert_select '.user-name h2', text: user.name
      assert_select 'h6', text: "Number of posts: #{user.posts_counter}"
    end

    assert_select '.bio-description' do
      assert_select 'h3', text: 'Bio'
      assert_select 'p', text: user.bio
    end

    user.recent_posts.each do |post|
      assert_select '.user-post' do
        assert_select 'h3', text: post.title
        assert_select 'div', text: post.text
        assert_select '.comment', text: "Comments: #{post.comments_counter}"
        assert_select '.like', text: "Likes: #{post.likes_counter}"
      end
    end

    assert_select '.see-posts' do
      assert_select 'a[href=?]', user_posts_path(user), text: 'See all posts'
    end
  end

  test 'redirects to the post show page when a user clicks on a post' do
    user = users(:one)
    post = Post.create(title: 'Post 1', text: 'Post 1 text', comments_counter: 5, likes_counter: 10, author: user)

    get user_path(user)

    assert_response :success

    assert_select '.user-post' do |elements|
      assert_operator elements.size, :>=, 1

      assert_select 'h3', text: post.title
      assert_select 'div', text: post.text
    end
  end
end
