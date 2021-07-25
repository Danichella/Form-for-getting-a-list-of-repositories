module Mutations
  # @params user_id [Integer] user id
  # @return [Array of strings] array of repo`s names
  class FindRepoByUserId < Mutations::BaseMutation
    argument :user_id, Integer, required: true

    field :repos_name, [String], null: true

    def resolve(user_id:)
      repos_name = Repo.where(user_id: user_id).map(&:name)
      return {} unless repos_name

      { repos_name: repos_name }
    end
  end
end
