require 'faraday'

module Mutations
  # @params login [String] login
  # @return [UserType] user object that has this login
  class FindUserByLogin < Mutations::BaseMutation
    argument :login, String, required: true

    field :user, Types::UserType, null: true

    def resolve(login:)
      user = User.find_by(login: login)
      user ||= create_user(login)
      create_repos(login, user)
      return {} unless user

      { user: user }
    end

    def create_user(login)
      response = Faraday.get "https://api.github.com/users/#{login}"
      result = JSON.parse(response.body)
      params = { login: login, name: result['name'] }
      User.create(params)
    end

    def create_repos(login, user)
      response = Faraday.get "https://api.github.com/users/#{login}/repos"
      result = JSON.parse(response.body)
      result.each do |element|
        begin
          params = { name: element['name'], user: user }
        rescue TypeError
          next
        end
        Repo.create(params) unless Repo.find_by(name: params[:name], user: user)
      end
    end
  end
end
