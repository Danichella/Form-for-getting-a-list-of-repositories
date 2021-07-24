class UsersController < ApplicationController
  def show
    if params[:id]
        @user = User.find(params[:id])
        @repos = Repo.where(user_id: params[:id])
    end
  end

  def create
    @user = User.find_by(login: params[:login])

    redirect_to @user
  end

  def update
    @user = User.find_by(login: params[:login])

    redirect_to @user
  end
end
