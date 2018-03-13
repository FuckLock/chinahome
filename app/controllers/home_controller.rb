class HomeController < ApplicationController
  def index
    @topics = Topic.with_excellent
    @sections = Section.includes(:nodes)
  end
end
