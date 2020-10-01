module Types
  class QueryType < Types::BaseObject
    field :user, UserType, null: false do
      argument :login, String, required: true
    end


    def user(login: nil)
      user = User.find_by(login: login)
      if user
        user
      else
        search_api_user(login)
        User.find_by(login: login)
      end
    end

    private

    def search_api_user(login)
      search = Faraday.get("https://api.github.com/users/#{login}")
      result = JSON.parse(search.body)
      user = User.new(login: login, name: result["name"])
      if user.save
        search_api_user_repos(login, user.id)
      else
        raise 'Incorrect login'
      end
    end

    def search_api_user_repos(login, user_id)
      search = Faraday.get("https://api.github.com/users/#{login}/repos")
      result = JSON.parse(search.body)
      result.each do |repo|
        @repo = Repo.new(name: repo["name"], user_id: user_id)
        @repo.save
      end
    end
  end
end
