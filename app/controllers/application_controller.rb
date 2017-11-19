# @Author: baodongdong
# @Date:   2017-11-19T09:52:24+08:00
# @Last modified by:   baodongdong
# @Last modified time: 2017-11-19T19:23:21+08:00



class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :turbolinks_app?

  def turbolinks_app?
    @turbolinks_ap ||= request.user_agent.to_s.include?("turbolinks-app")
  end
end
