class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all
    if params[:q].present?
      qstr = "%#{params[:q].gsub(/\s+/, '').downcase}%"
      @users = User.where("lower(login) like ? or lower(email) like ?", qstr, qstr)
    end
  end
end
