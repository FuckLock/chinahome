class SearchController < ApplicationController
  before_action :authenticate_user!, only: [:users]

  def users
    @result = User.search(params[:q], limit: params[:limit] || 10)
    render json: @result.collect { |u| { login: u.login, name: u.name, avatar_url: u.large_avatar_url } }
  end
end
