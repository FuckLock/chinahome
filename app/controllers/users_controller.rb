class UsersController < ApplicationController
  before_action :set_user, expect: [:index]

  def show
    # fresh_when @user
  end

  def set_user
    @user = User.find_by(login: params[:id])
  end

end
