class RepliesController < ApplicationController
  include UsersHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  before_action :find_reply, only: %i[like unlike]

  def create
    @reply = Reply.new(reply_params)
    @reply.topic_id = params[:topic_id]
    @reply.user_id = current_user.id
    @msg = if @reply.save
             "回复成功"
           else
             @reply.errors.full_messages.join("<br />")
           end
    @topic = Topic.find_by(id: params[:topic_id])
    @replies_without_action = @topic.replies.order("id asc").without_action.includes(:user)
  end

  def reply_params
    params.require(:reply).permit(:body)
  end

  def like
    current_user.like_reply(@reply)
    render json: {
      data: {
        like_users_count: @reply.like_users.count,
        like_users: user_avatar_tag(@reply.like_users, :xs, link: true)
      }
    }
  end

  def unlike
    current_user.unlike_reply(@reply)
    render json: {
      data: {
        like_users_count: @reply.like_users.count,
        like_users: user_avatar_tag(@reply.like_users, :xs, link: true)
      }
    }
  end

  private
  def find_reply
    @reply = Reply.find_by(id: params[:id])
  end
end
