module Users
  module UserActions
    extend ActiveSupport::Concern

    def follow
      @user = User.find_by(login: params[:id])
      case params[:page]
      when "sidebar"
        redirect_to new_user_session && return unless current_user
        current_user.follow_user @user
      when "following"
        current_user.follow_user @user
        @user = params[:sidebar_user] ? User.find_by(login: params[:sidebar_user]) : current_user
        @users = @user.following_users.order("id asc").page(params[:page]).per(60)
        render template: "users/following_template"
      when "followed"
        current_user.follow_user @user
        @user = params[:sidebar_user] ? User.find_by(login: params[:sidebar_user]) : current_user
        @users = @user.followed_users.order("id asc").page(params[:page]).per(60)
        render template: "users/followed_template"
      end
    end

    def unfollow
      @user = User.find_by(login: params[:id])
      case params[:page]
      when "sidebar"
        redirect_to new_user_session && return unless current_user
        current_user.unfollow_user @user
      when "following"
        current_user.unfollow_user @user
        @user = params[:sidebar_user] ? User.find_by(login: params[:sidebar_user]) : current_user
        @users = @user.following_users.order("id asc").page(params[:page]).per(60)
        render template: "users/following_template"
      when "followed"
        current_user.unfollow_user @user
        @user = params[:sidebar_user] ? User.find_by(login: params[:sidebar_user]) : current_user
        @users = @user.followed_users.order("id asc").page(params[:page]).per(60)
        render template: "users/followed_template"
      end
    end

    def calendar
      data = @user.calendar_data
      render json: data
    end

    def following
      @users = @user.following_users.order("id asc").page(params[:page]).per(60)
    end

    def followed
      @users = @user.followed_users.order("id asc").page(params[:page]).per(60)
    end

    def topics
      @topics = @user.topics.includes(:node).order("created_at desc").page(params[:page]).per(20)
    end

    def replies
      @replies = @user.replies.without_action.includes(:topic).order("created_at desc").page(params[:page]).per(20)
    end

    def collects
      @collects = @user.collecting_topics.order("created_at desc").page(params[:page]).per(20)
    end

    def hot_topics
      @hot_topics = @user.topics.hot_topics(0)
    end

  end
end
