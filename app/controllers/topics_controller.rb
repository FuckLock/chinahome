class TopicsController < ApplicationController
  before_action :find_sections, only: %i[index new recent no_reply]

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
    @replies = Reply.where(topic_id: @topic.id)
  end

  def recent
    @topics = Topic.order(id: :desc).includes(:user)
    render action: :index
  end

  def no_reply
    @topics = Topic.no_reply
    render action: :index
  end

  private
  def find_sections
    @sections = Section.includes(:nodes)
  end
end
