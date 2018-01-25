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

  def calendar
    data = @user.calendar_data
    render json: data
  end

  def following
    @users = @user.following_users.order("id asc").page(params[:page]).per(60)
  end

  def followed
    @users = @user.followed_users.order("id asc").page(params[:page]).per(60)
  end

  def topics
    @topics = @user.topics.includes(:node).order("created_at desc").page(params[:page]).per(20)
  end

  def replies
    @replies = @user.replies.without_action.includes(:topic).order("created_at desc").page(params[:page]).per(20)
  end

  def collects
    @collects = @user.collecting_topics.order("created_at desc").page(params[:page]).per(20)
  end

  def cancelfollow
    @user = User.find_by(login: params[:id])
    current_user.unfollow_user @user
    @users = current_user.following_users.order("id asc").page(params[:page]).per(60)
    @current_user = current_user
  end
end
