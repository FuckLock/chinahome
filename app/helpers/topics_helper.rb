module TopicsHelper
  def like_topic_tag
    if current_user
      like = "active" if current_user.like_topic? @topic
    end
    like = " #{topic.like_users.count} 个 赞" if @topic.like_users.present?
    users = user_avatar_tag(@topic.like_users, :xs, link: true)
    content = link_to(raw("<i class='fa fa fa-heart'></i><span>#{like}</span>"), "#",
                      class: " button-heart #{like}", data: { id: @topic.id })
    raw(content_tag("li", content, "data-toggle" => "popover", "data-content" => users.to_s))
  end

  def collect_topic_tag
    if current_user
      collect = "active" if current_user.collect_topic?(@topic)
    end
    content = link_to(raw('<i class="fa fa-bookmark"></i>收藏'), "#",
                      class: "button-collect #{collect}", data: { id: @topic.id })
    raw(content_tag("li", content))
  end
end
