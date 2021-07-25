module Types
  class MutationType < Types::BaseObject
    field :find_by_login, mutation: Mutations::FindUserByLogin
    field :find_by_id, mutation: Mutations::FindUserById
    field :find_repo_by_user_id, mutation: Mutations::FindRepoByUserId
  end
end
