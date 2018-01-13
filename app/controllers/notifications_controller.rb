class NotificationsController < ApplicationController
  def index
    @notifications = notifications.includes(:subject).order('id desc').page(params[:page])
    unread_ids = @notifications.reject{|notification| notification.read_at.present? }.select(&:id)
    Notification.where(id: unread_ids).update_all(read_at: Time.now)
    @notification_groups = @notifications.group_by { |note| note.created_at.to_date }
  end

  def clean
    notifications.delete_all
    redirect_to notifications_path
  end

  private

  def notifications
    raise "You need reqiure user login for /notifications page." unless current_user
    Notification.where(target_id: current_user.id)
  end

end
