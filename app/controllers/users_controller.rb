class UsersController < ApplicationController

  def search
    @user = User.find_by(login: user_params[:login])
    if @user.nil?
      redirect_to root_path
    else
      @repos = @user.repos
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :name)
  end
end
