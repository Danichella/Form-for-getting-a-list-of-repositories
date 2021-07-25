require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users/:id' do
    let!(:user) { create :user }

    it 'returns a successful response' do
      get "/users/#{user.id}"
      expect(response).to(be_successful)
    end

    it 'renders the show template' do
      get "/users/#{user.id}"
      expect(response).to(render_template(:show))
    end
  end

  describe 'PUTS /users' do
    it 'creates user record' do
      expect do
        post '/users', params: { login: 'danichella', name: 'Даниїл' }
      end.to change { User.count }.by(1)
    end
  end
end
