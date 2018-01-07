class RepliesController < ApplicationController
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
end
