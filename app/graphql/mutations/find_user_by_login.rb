module Mutations
  # @params login [String] login
  # @return [UserType] user object that has this login
  class FindUserByLogin < Mutations::BaseMutation
    argument :login, String, required: true

    field :user, Types::UserType, null: true

    def resolve(login:)
      user = User.find_by!(login: login)
      return {} unless user

      { user: user }
    end
  end
end
