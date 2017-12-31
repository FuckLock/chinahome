class TopicsController < ApplicationController
  include UsersHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  before_action :find_sections, only: %i[index new recent no_reply node]

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
    if current_user
      ids = current_user.block_node_ids
      @topics = Topic.exclude_column_ids(ids).includes(:node)
    else
      @topics = Topic.includes(:node)
    end
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

  def node
    @node = Node.find_by(id: params[:id])
    @topics = @node.topics
    render action: :index
  end

  def like
    @topic = Topic.find_by(id: params[:id])
    current_user.like_topic(@topic)
    render json: {
      data: {
        like_users_count: @topic.like_users.count,
        like_users: user_avatar_tag(@topic.like_users, :xs, link: true)
      }
    }
  end

  def unlike
    @topic = Topic.find_by(id: params[:id])
    current_user.unlike_topic(@topic)
    render json: {
      data: {
        like_users_count: @topic.like_users.count,
        like_users: user_avatar_tag(@topic.like_users, :xs, link: true)
      }
    }
  end

  private

  def find_sections
    @sections = Section.includes(:nodes)
  end
end
