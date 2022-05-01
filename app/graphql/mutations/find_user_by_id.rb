module Mutations
  # @params id [Integer] id
  # @return [UserType] user object that has this id
  class FindUserById < Mutations::BaseMutation
    argument :id, Integer, required: true

    field :user, Types::UserType, null: true

    def resolve(id:)
      user = User.find_by(id: id)
      return { user: { error: "#{user&.login || 'This user'} doesn't have name" } } if user&.name.blank?

      { user: user&.attributes }
    end
  end
end
