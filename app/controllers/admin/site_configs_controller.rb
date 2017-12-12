class Admin::SiteConfigsController < Admin::ApplicationController
  before_action :set_setting, only: %i[edit update]

  def index

  end

  def edit

  end

  def set_setting
    @site_config = Setting.find_by(var: params[:id]) || Setting.new(var: params[:id])
  end

  def update
    redirect_to admin_site_configs_path and return if @site_config.value == setting_param[:value]
    @site_config.value = setting_param[:value]
    @site_config.save
    redirect_to admin_site_configs_path, notice: "保存成功"
  end

  def setting_param
    params[:setting].permit!
  end
end
