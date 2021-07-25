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
end
