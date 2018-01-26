class UsersController < ApplicationController
  before_action :set_user, expect: [:index]

  include Users::UserActions

  def show
    # fresh_when @user
    @hot_topics = @user.topics.hot_topics(0)
  end

  private

  def set_user
    @user = User.find_by(login: params[:id])
  end
end
