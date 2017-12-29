class LikesController < ApplicationController

  def like
    current_user.like_topics
  end

  def unlike

  end
end
