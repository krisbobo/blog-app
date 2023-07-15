require 'test_helper'

class PostIndexTest < ActionDispatch::IntegrationTest
  test 'displays user post index correctly' do
    user = users(:one)
    Post.create(title: 'Post 1', text: 'Post 1 text', comments_counter: 5, likes_counter: 10, author: user)
    Post.create(title: 'Post 2', text: 'Post 2 text', comments_counter: 3, likes_counter: 7, author: user)

    get user_posts_path(user)
    assert_response :success
    assert_select '.post-index-container'

    assert_select '.user-description' do
      assert_select '.img-div'
      assert_select "img[src*='#{user.photo}']"
      assert_select '.user-name h2', text: user.name
      assert_select 'h6', text: "Number of posts: #{user.posts_counter}"
    end

    assert_select '.title-text' do |elements|
      assert_operator elements.size, :>=, 1

      elements.each do |element|
        post_title = element.at('h2').text.strip
        post_body = element.at('p').text.strip

        assert_select 'h2', text: post_title
        assert_select 'p', text: post_body

        assert_select '.comment-count' do
          assert_select '.comment', text: /Comments: \d+/
          assert_select '.like', text: /Likes: \d+/
        end

        next unless element.at('.comment-section')

        assert_select '.comment-section' do
          assert_select 'h4', text: /#{user.name}:/
          assert_select 'p', text: element.at('.comment-section p').text
        end
      end
    end
  end
end
