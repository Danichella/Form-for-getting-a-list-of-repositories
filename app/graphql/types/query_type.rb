module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :users,
          [Types::UserType],
          null: false,
          description: 'Returns a list of users'
    field :repos,
          [Types::RepoType],
          null: false,
          description: 'Returns a list of repos'

    def users
      User.all
    end

    def repos
      Repo.all
    end
  end
end
