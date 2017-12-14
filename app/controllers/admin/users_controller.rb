class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all
    if params[:q].present?
      qstr = "%#{params[:q].gsub(/\s+/, '').downcase}%"
      @users = User.where("lower(login) like ? or lower(email) like ?", qstr, qstr)
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(params[:user].permit!)
      redirect_to(edit_admin_user_path(@user.id), notice: "User was successfully updated.")
    else
      render action: "edit"
    end
  end
end
