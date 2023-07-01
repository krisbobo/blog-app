require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #index' do
    it 'returns a success response' do
      get user_posts_path(user_id: 1)
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get user_posts_path(user_id: 1)
      expect(response).to render_template('index')
    end

    it 'includes the correct placeholder text' do
      get user_posts_path(user_id: 1)
      expect(response.body).to include('List of all posts')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get user_post_path(user_id: 1, id: 1)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get user_post_path(user_id: 1, id: 1)
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text' do
      get user_post_path(user_id: 1, id: 1)
      expect(response.body).to include('Post for a given user')
    end
  end
end
