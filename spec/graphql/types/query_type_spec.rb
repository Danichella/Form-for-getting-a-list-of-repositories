require 'rails_helper'

RSpec.describe Types::QueryType do
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
