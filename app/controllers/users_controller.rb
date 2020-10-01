class UsersController < ApplicationController

  def search
    @github_login = user_params[:login]
    @user = User.find_by(login: @github_login)
    if @user.nil?
      search_api_user
      @repos = @user.repos
    else
      @repos = @user.repos
    end
  end

  def search_api_user
    search = Faraday.get("https://api.github.com/users/#{@github_login}")
    result = JSON.parse(search.body)
    @user = User.new(login: @github_login, name: result["name"])
    if @user.save
      search_api_user_repos(@user.id)
    else
      render html: helpers.tag.strong('Incorrect login')
    end
  end

  def search_api_user_repos(user_id)
    search = Faraday.get("https://api.github.com/users/#{@github_login}/repos")
    result = JSON.parse(search.body)
    result.each do |repo|
      @repo = Repo.new(name: repo["name"], user_id: user_id)
      @repo.save
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :name)
  end
end
