class Admin::TopicsController < Admin::ApplicationController
  before_action :set_topic, only: %i[suggest unsuggest excellent unexcellent ban unban action]
  before_action :authenticate_user!, only: %i[action]

  def index
    @topics = Topic.all
  end

  def action
    case params[:type]
    when "place_top"
      @topic.place_top!
      @msg = "话题已经成功置顶。"
      render partial: "place_top"
    when "cancel"
      @topic.cancel!
      @msg = "话题已经取消置顶。"
      render partial: "cancel"
    when "excellent"
      @reply = @topic.excellent!
      @msg = "话题已经加精成功。"
      render template: "admin/topics/excellent"
    when "unexcellent"
      @reply = @topic.unexcellent!
      @msg = "话题已经取消加精。"
      render partial: "unexcellent"
    when "ban"
      render partial: "ban"
    when "banban"
      params[:reason] ||= ""
      params[:reason_text] ||= ""
      @reply = @topic.banban!(reason: params[:reason], reason_text: params[:reason_text])
      @msg = "已转移到 NoPoint 节点。"
      render partial: "banban"
    when "close"
      @reply = @topic.close!
      @msg = "话题已关闭，将不再接受任何新的回复。"
      render partial: "close"
    when "open"
      @reply = @topic.open!
      @msg = "话题已重启开启。"
      render partial: "open"
    end
  end

  def set_topic
    @topic = Topic.unscoped.find(params[:id])
  end
end
