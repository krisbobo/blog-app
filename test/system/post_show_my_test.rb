require 'application_system_test_case'

class PostShowMyTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
  end

  test 'displays post show page correctly' do
    get user_post_path(@post.author.id, @post.id)

    assert_select '.comment-like-btn' do
      assert_select 'form' do
        assert_select 'input[type="submit"][value="Like"].btn_1'
      end

      assert_select 'button[type="button"].btn_2' do
        assert_select 'a.user_link', text: 'Comment'
      end
    end
  end
end
