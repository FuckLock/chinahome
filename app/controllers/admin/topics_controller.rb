class Admin::TopicsController < Admin::ApplicationController
  before_action :set_topic, only: %i[suggest unsuggest excellent unexcellent ban unban action]

  def index
    @topics = Topic.all
  end

  def suggest
    @topic.update_attribute(:suggested_at, Time.now)
    redirect_to(@topic, notice: "置顶成功")
  end

  def unsuggest
    @topic.update_attribute(:suggested_at, nil)
    redirect_to(@topic, notice: "取消置顶")
  end

  def excellent
    @reply = @topic.excellent!
    @msg = "加精成功"
  end

  def unexcellent
    @reply = @topic.unexcellent!
    @msg = "加精已经取消"
  end

  def ban
  end

  def unban
  end

  def action
    case params[:type]
    when "ban"
      params[:reason] ||= ""
      params[:reason_text] ||= ""
      @reply = @topic.ban!(reason: params[:reason],reason_text: params[:reason_text])
      @msg = "已转移到 NoPoint 节点。"
      render partial: 'banban'
    when "close"
      @reply = @topic.close!
      @msg = "话题已关闭，将不再接受任何新的回复。"
      render partial: 'close'
    when "open"
      @reply = @topic.open!
      @msg = "话题已重启开启。"
      render partial: 'open'
    end

  end

  def set_topic
    @topic = Topic.unscoped.find(params[:id])
  end
end
