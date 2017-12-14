class Admin::TopicsController < Admin::ApplicationController
  def index
    @topics = Topic.all
  end
end
