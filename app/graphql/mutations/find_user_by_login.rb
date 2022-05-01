module Mutations
  # require 'faraday'
  # @params login [String] login
  # @return [UserType] user object that has this login
  class FindUserByLogin < Mutations::BaseMutation
    argument :login, String, required: true

    field :user, Types::UserType, null: true

    def resolve(login:)
      return unless login

      user = create_user(login)
      create_repos(login, user)
      return { user: { error: "GitHub user with username #{login} not found" } } unless user

      { user: user.attributes }
    end

    def create_user(login)
      response = Faraday.get "https://api.github.com/users/#{login.delete(' ')}"
      result = JSON.parse(response.body)
      return if result['message'].present?

      User.find_or_create_by(user_params(result))
    end

    def create_repos(login, user)
      return unless user && login

      response = Faraday.get "https://api.github.com/users/#{login.delete(' ')}/repos"
      result = JSON.parse(response.body)
      return if result.blank?

      result.each do |element|
        user.repos.find_or_create_by(repo_params(element))
      end
    end

    def user_params(response)
      {
        login: response['login'],
        name: response['name'],
        profile_url: response['html_url'],
        avatar_url: response['avatar_url']
      }
    end

    def repo_params(response)
      {
        name: response['name'],
        repo_url: response['html_url']
      }
    end
  end
end
