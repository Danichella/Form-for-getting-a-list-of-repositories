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

  describe 'POST /users' do
    let(:user) { build(:user) }
    let(:repos) { build_pair(:repo) }
    let(:stubbed_users_response) do
      {
        login: user.login,
        name: user.name,
        html_url: user.profile_url,
        avatar_url: user.avatar_url
      }
    end
    let(:stubbed_repos_response) do
      repos.map do |repo|
        {
          name: repo.name,
          html_url: repo.repo_url
        }
      end
    end

    before do
      stub_request(:get, %r{api.github.com/users/#{user.login}})
        .to_return(status: 200, body: stubbed_users_response.to_json, headers: {})
      stub_request(:get, %r{api.github.com/users/#{user.login}/repos})
        .to_return(status: 200, body: stubbed_repos_response.to_json, headers: {})
    end

    it 'creates user record' do
      expect do
        post '/users', params: { login: user.login }
      end.to change(User, :count).by(1)
    end

    it 'creates repos record' do
      expect do
        post '/users', params: { login: user.login }
      end.to change(Repo, :count).by(2)
    end
  end
end
