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
  end

  def reply_params
    params.require(:reply).permit(:body)
  end
end
