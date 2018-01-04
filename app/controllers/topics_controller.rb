class TopicsController < ApplicationController
  include UsersHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  before_action :find_sections, only: %i[index new recent no_reply node edit]
  before_action :find_topic, only: %i[show edit update destroy like unlike collect uncollect]
  before_action :authenticate_user!, only: %i[new create preview]

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    @topic.node_name = Node.node_name(topic_params[:node_id])
    @topic.save
    redirect_to topics_path
  end

  def show
    @reply = Reply.new
    @replies = @topic.replies.order("id asc")
    @ban_reply = @topic.replies.where(action: "ban").order("id desc").limit(1).first
  end

  def index
    @place_top_topics = Topic.place_top.limit(3)
    @topics = Topic.without_place_top
    @topics = if current_user
                @topics.exclude_column_ids(current_user.block_node_ids)
              end
    @topics.without_ban.includes(:node)
  end

  def edit
  end

  def update
    node_name = Node.node_name(topic_params[:node_id])
    @topic.ban = false if node_name != "NoPoint"
    @topic.node_name = node_name
    @topic.update_attributes(topic_params)
    @topic.save
    redirect_to topic_path(@topic)
  end

  def destroy
    @topic.destroy
    redirect_to @topic
  end

  def preview
    @body = params[:body]
    respond_to do |format|
      format.json
    end
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
    current_user.like_topic(@topic)
    render json: {
      data: {
        like_users_count: @topic.like_users.count,
        like_users: user_avatar_tag(@topic.like_users, :xs, link: true)
      }
    }
  end

  def unlike
    current_user.unlike_topic(@topic)
    render json: {
      data: {
        like_users_count: @topic.like_users.count,
        like_users: user_avatar_tag(@topic.like_users, :xs, link: true)
      }
    }
  end

  def collect
    current_user.collect_topic(@topic)
  end

  def uncollect
    current_user.uncollect_topic(@topic)
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body, :node_id)
  end

  def find_sections
    @sections = Section.includes(:nodes)
  end

  def find_topic
    @topic = Topic.find_by(id: params[:id])
  end
end
