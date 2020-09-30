module Types
  class QueryType < Types::BaseObject
    field :user, UserType, null: false

    def user
      User.find_by(login: 'GIT_login')
    end
  end
end
