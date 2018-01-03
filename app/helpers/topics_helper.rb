module TopicsHelper
  def like_topic_tag
    if current_user
      like = "active" if current_user.like_topic? @topic
    end
    like_counts = " #{@topic.like_users.count} 个 赞" if @topic.like_users.present?
    users = user_avatar_tag(@topic.like_users, :xs, link: true)
    content = link_to(raw("<i class='fa fa fa-heart'></i><span>#{like_counts}</span>"), "#",
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

  def suggest_topic_tag
    content = if @topic.suggested_at.present?
                link_to raw("<i class='fa fa-angle-double-up'></i> 取消"),
                        unsuggest_admin_topic_path(@topic), method: :post, remote: true
              else
                link_to raw('<i class="fa fa-angle-double-up"></i>置顶'),
                        suggest_admin_topic_path(@topic), method: :post, remote: true
              end
    raw(content_tag("li", content))
  end

  def excellent_topic_tag
    return nil unless @topic.excellent.zero?
    content = link_to raw('<i class="fa fa-diamond"></i>加精'),
                      excellent_admin_topic_path(@topic), method: :post, remote: true
    raw(content_tag("li", content, class: "excell-li"))
  end

  def ban_topic_tag
    content = link_to raw('<i class="fa fa-ban"></i>屏蔽'),
        ban_admin_topic_path(@topic), method: :post, remote: true
    raw(content_tag("li", content, class: "ban-li"))
  end
end
