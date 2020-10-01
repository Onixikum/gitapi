Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

  root 'static_page#home'

  resources :users, only: :search do
    post 'search', on: :collection
    get 'search', on: :collection
  end
end
