module Types
  class QueryType < Types::BaseObject
    field :user, [UserType], null: false

    def user
      User.find_by(login: 'GIT_login_2')
    end
  end
end
