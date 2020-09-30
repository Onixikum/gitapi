module Types
  class QueryType < Types::BaseObject
    field :user, UserType, null: false
    field :repo, [RepoType], null: false

    def user
      User.find_by(login: 'GIT_login_2')
    end

    def repo
      user.repos
    end
  end
end
