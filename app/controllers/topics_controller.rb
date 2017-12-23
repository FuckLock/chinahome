class TopicsController < ApplicationController
  def index; end

  def new
    @topic = Topic.new
    # fresh_when @topic
  end

  def preview
    @body = params[:body]
    respond_to do |format|
      format.json
    end
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    @topic.save
  end

  def topic_params
    params.require(:topic).permit(:title, :body, :node_id)
  end

  def index
    @topics = Topic.includes(:node)

  end

  def show
    @topic = Topic.find_by(id: params[:id])
    @reply = Reply.new
  end
end
