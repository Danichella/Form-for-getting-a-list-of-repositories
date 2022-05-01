module Types
  class UserType < Types::BaseObject
    field :id, ID, null: true
    field :login, String, null: true
    field :name, String, null: true
    field :profile_url, String, null: true
    field :avatar_url, String, null: true
    field :error, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
