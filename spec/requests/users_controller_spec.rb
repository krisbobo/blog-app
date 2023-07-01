require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    it 'returns a success response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template('index')
    end

    it 'includes the correct placeholder text' do
      get users_path
      expect(response.body).to include('List of all users')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get '/users/:id', as: 'user'
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get '/users/:id', as: 'user'
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text' do
      get '/users/:id', as: 'user'
      expect(response.body).to include('Show a user')
    end
  end
end
