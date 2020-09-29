module Types
  class UserType < Types::BaseObject
    field :login, String, null: false
    field :name, String, null: false
  end
end
