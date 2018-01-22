class UsersController < ApplicationController
  before_action :set_user, expect: [:index]
  before_action :authenticate_user!, only: %i[follow]

  def show
    # fresh_when @user
  end

  def set_user
    @user = User.find_by(login: params[:id])
  end

  def follow
    @user = User.find_by(login: params[:id])
    current_user.follow_user(@user)
  end

  def unfollow
    @user = User.find_by(login: params[:id])
    current_user.unfollow_user @user
  end
end
