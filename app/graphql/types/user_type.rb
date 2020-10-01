module Types
  class UserType < Types::BaseObject
    field :login, String, null: false
    field :name, String, null: false
    field :repos, [RepoType], null: false
  end
end
