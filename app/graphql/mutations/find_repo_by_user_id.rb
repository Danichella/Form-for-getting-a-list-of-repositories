module Mutations
  # @params user_id [Integer] user id
  # @return [Array of strings] array of repo`s names
  class FindRepoByUserId < Mutations::BaseMutation
    argument :user_id, Integer, required: true

    field :repos, [Types::RepoType], null: true

    def resolve(user_id:)
      user = User.find_by(id: user_id)
      repos = user&.repos
      if repos.blank?
        return(
          {
            repos: [{ name: "#{user&.name || user&.login || 'This user'} doesn't have any public repositories" }]
          }
        )
      end

      { repos: repos }
    end
  end
end
