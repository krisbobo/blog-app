# require 'test_helper'
require 'application_system_test_case'

class PostShowTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
  end

  test 'displays post show page correctly' do
    get user_post_path(@post.author.id, @post.id)

    assert_response :success

    assert_select '.post-show-container' do
      assert_select '.title-over-all' do
        assert_select '.title-container' do
          assert_select '.title-author' do
            assert_select 'p', text: @post.title
            assert_select 'p', text: "by #{@post.author.name}"
          end

          assert_select '.like-comment' do
            assert_select 'p', text: "Comments: #{@post.comments_counter}"
            assert_select 'p', text: "Likes: #{@post.likes_counter}"
          end
        end

        assert_select 'p', text: @post.text
      end

      @post.recent_comments.each do |comment|
        assert_select '.comment-section' do
          assert_select 'h4', text: "#{comment.author.name}:"
          assert_select 'p', text: comment.text
        end
      end
    end
  end
end
