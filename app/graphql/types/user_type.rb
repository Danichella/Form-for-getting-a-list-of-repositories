module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :login, String, null: true
    field :name, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
