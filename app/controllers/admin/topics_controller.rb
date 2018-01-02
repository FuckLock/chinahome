class Admin::TopicsController < Admin::ApplicationController
  before_action :set_topic, only: %i[suggest unsuggest excellent unexcellent ban unban]

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
    @topic.update_attribute(:excellent, 1)
    @reply = Reply.new(user_id: current_user.id, topic_id: @topic.id, action: "excellent", body: "")
    @reply.save(validate: false)
    @msg = "加精成功"
  end

  def unexcellent
    @topic.update_attribute(:excellent, 0)
    @reply = Reply.new(user_id: current_user.id, topic_id: @topic.id, action: "unexcellent", body: "")
    @reply.save(validate: false)
    @msg = "加精已经取消"
  end

  def ban
  end

  def unban
  end

  def action
    case params[:type]
    when "ban"
      params[:reason_text] ||= params[:reason] || ""
      render partial: 'banban'
    end
  end

  def set_topic
    @topic = Topic.unscoped.find(params[:id])
  end
end
