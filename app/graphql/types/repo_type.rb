module Types
  class RepoType < Types::BaseObject
    field :id, ID, null: true
    field :name, String, null: true
    field :repo_url, String, null: true
    field :user_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
