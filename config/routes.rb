# frozen_string_literal: true

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users

  post '/', to: 'users#create'
  post '/users/:id', to: 'users#update'

  root to: 'users#show'
end
