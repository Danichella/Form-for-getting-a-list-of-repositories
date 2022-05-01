require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'Query' do
    let(:query) do
      %(query {
        users {
            login
            name
        }
        repos {
            name
        }
    })
    end

    subject(:result) do
      FormForGettingAListOfRepositoriesSchema.execute(query).as_json
    end

    context 'when users are queried' do
      let!(:users) { create_pair(:user) }

      it 'return all users with login and name' do
        expect(result.dig('data', 'users')).to match_array(
          users.map { |user| { 'login' => user.login, 'name' => user.name } }
        )
      end
    end

    context 'when repos are queried' do
      let!(:repos) { create_pair(:repo) }

      it 'return all repos with name' do
        expect(result.dig('data', 'repos')).to match_array(
          repos.map { |repo| { 'name' => repo.name } }
        )
      end
    end
  end

  describe 'Mutation' do
    subject(:result) do
      FormForGettingAListOfRepositoriesSchema.execute(mutation).as_json
    end
    let(:user) { create(:user) }
    let(:stubbed_users_response) do
      {
        login: user.login,
        name: user.name,
        html_url: user.profile_url,
        avatar_url: user.avatar_url
      }
    end

    before do
      stub_request(:get, %r{api.github.com/users/#{user.login}})
        .to_return(status: 200, body: stubbed_users_response.to_json, headers: {})
      stub_request(:get, %r{api.github.com/users/#{user.login}/repos})
        .to_return(status: 200, body: [].to_json, headers: {})
    end

    context 'when find_user_by_login are queried' do
      let(:mutation) do
        %(mutation{
          findByLogin(input: {login: \"#{user.login}\"}){
            user{
              login,
              name,
              profileUrl,
              avatarUrl
            }
          }
      })
      end

      it 'return user id found by login' do
        expect(result.dig('data', 'findByLogin', 'user')).to eq({
          login: user.login,
          name: user.name,
          profileUrl: user.profile_url,
          avatarUrl: user.avatar_url
        }.stringify_keys)
      end
    end

    context 'when find_user_by_id are queried' do
      let(:mutation) do
        %(mutation{
          findById(input: {id: #{user.id}}){
            user{
                name
            }
          }
      })
      end

      it 'return user name found by login' do
        expect(result.dig('data', 'findById', 'user', 'name')).to eq(user.name)
      end
    end

    context 'when find_repos_name_by_id are queried' do
      let!(:repos) { create_pair(:repo, user: user) }
      let(:mutation) do
        %(mutation {
          findRepoByUserId(input: {userId: #{user.id}}) {
            repos {
              name
            }
          }
      })
      end

      let(:expected_repos) { user.repos.map { |repo| { name: repo.name }.stringify_keys } }

      it 'return user name found by login' do
        expect(result.dig('data', 'findRepoByUserId', 'repos')).to match_array(expected_repos)
      end
    end
  end
end
