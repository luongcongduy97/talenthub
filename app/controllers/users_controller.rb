class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = policy_scope(User)
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end
end
