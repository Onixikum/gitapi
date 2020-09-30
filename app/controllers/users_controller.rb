class UsersController < ApplicationController

  def search

  end

  private

  def user_params
    params.require(:user).permit(:login, :name)
  end
end
