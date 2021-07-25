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
          users.map { |user| { 'login' => user.login, 'name' => user.name } },
        )
      end
    end

    context 'when repos are queried' do
      let!(:repos) { create_pair(:repo) }

      it 'return all repos with name' do
        expect(result.dig('data', 'repos')).to match_array(
          repos.map { |repo| { 'name' => repo.name } },
        )
      end
    end
  end

  describe 'Mutation' do
    let!(:user) { create(:user) }

    context 'when find_user_by_login are queried' do
      let(:mutation) do
        %(mutation{
          findByLogin(input: {login: \"#{user.login}\"}){
            user{
                id
            }
          }
      })
      end

      subject(:result) do
        FormForGettingAListOfRepositoriesSchema.execute(mutation).as_json
      end
      it 'return user id found by login' do
        expect(result.dig('data', 'findByLogin', 'user', 'id').to_i).to eq(user.id)
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

      subject(:result) do
        FormForGettingAListOfRepositoriesSchema.execute(mutation).as_json
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
            reposName
          }
      })
      end

      subject(:result) do
        FormForGettingAListOfRepositoriesSchema.execute(mutation).as_json
      end

      let(:names) { Repo.where(user_id: user.id).map(&:name) }

      it 'return user name found by login' do
        expect(result.dig('data', 'findRepoByUserId', 'reposName')).to match_array(names)
      end
    end
  end
end
