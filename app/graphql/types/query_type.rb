module Types
  class QueryType < Types::BaseObject
    field :user, UserType, null: false
    field :repo, [RepoType], null: false

    def user
      User.find_by(login: 'Onixikum')
    end

    def repo
      user.repos
    end
  end
end
