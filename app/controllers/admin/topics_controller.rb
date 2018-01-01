class Admin::TopicsController < Admin::ApplicationController
  before_action :set_topic, only: %i[suggest unsuggest]

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

  def set_topic
    @topic = Topic.unscoped.find(params[:id])
  end

end
