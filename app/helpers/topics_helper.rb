module TopicsHelper
  def like_topic_tag opts = {}
    if current_user
      like = "active" if current_user.like_topic? @topic
    end
    like_counts = " #{@topic.like_users.count} 个 赞" if @topic.like_users.present?
    users = user_avatar_tag(@topic.like_users, :xs, link: true)
    content = link_to(raw("<i class='fa fa fa-heart'></i><span>#{like_counts}</span>"), "#",
                      class: " button-heart #{like}", data: { id: @topic.id },
                      "data-toggle" => "popover", "data-content" => users.to_s)
    if opts[:label] == false
      raw(content)
    else
      raw(content_tag("li", content))
    end
  end

  def collect_topic_tag opts = {}
    if current_user
      collect = "active" if current_user.collect_topic?(@topic)
    end
    content = link_to(raw('<i class="fa fa-bookmark"></i>收藏'), "#",
                      class: "button-collect #{collect}", data: { id: @topic.id })
    if opts[:label] == false
      raw(content)
    else
      raw(content_tag("li", content))
    end
  end

  def place_top_topic_tag opts = {}
    return nil unless @admin
    content = if @topic.place_top
                link_to raw("<i class='fa fa-angle-double-up'></i> 取消"),
                        action_admin_topic_path(@topic, type: "cancel"), method: :post, remote: true
              else
                link_to raw('<i class="fa fa-angle-double-up"></i>置顶'),
                        action_admin_topic_path(@topic, type: "place_top"), method: :post, remote: true
              end
    if opts[:label] == false
      raw(content)
    else
      raw(content_tag("li", content))
    end
  end

  def excellent_topic_tag opts = {}
    return nil unless @admin
    return nil if @topic.excellent
    content = link_to raw('<i class="fa fa-diamond"></i>加精'),
                      action_admin_topic_path(@topic, type: "excellent"), method: :post, remote: true
    if opts[:label] == false
      raw(content)
    else
      raw(content_tag("li", content, class: "excell-li"))
    end
  end

  def ban_topic_tag opts = {}
    return nil unless @admin
    return nil if @topic.ban
    content = link_to raw('<i class="fa fa-ban"></i>屏蔽'),
                      action_admin_topic_path(@topic, type: "ban"), method: :post, remote: true
    if opts[:label] == false
      raw(content)
    else
      raw(content_tag("li", content, class: "ban-li"))
    end
  end

  def discuss_topic_tag opts = {}
    return nil unless @user || @admin
    content = if @topic.discuss
                link_to raw('<i class="fa fa-check"></i>'),
                        action_admin_topic_path(@topic, type: "close"), method: :post, remote: true,
                        "data-toggle" => "tooltip", "data-placement" => "top", title: "关闭讨论／问题已解决"
              else
                link_to raw('<i class="fa fa-undo"></i>'),
                        action_admin_topic_path(@topic, type: "open"), method: :post, remote: true,
                        "data-toggle" => "tooltip", "data-placement" => "top", title: "重新开启话题"
              end
    if opts[:label] == false
      raw(content)
    else
      raw(content_tag("li", content))
    end
  end

  def edit_topic_tag opts = {}
    return nil unless @user || @admin
    content = link_to raw('<i class="fa fa-pencil"></i>'), edit_topic_path(@topic),
              "data-toggle" => "tooltip", "data-placement" => "top", title: "编辑话题"
    if opts[:label] == false
      raw(content)
    else
      raw(content_tag("li", content))
    end
  end

  def delete_topic_tag opts = {}
    return nil unless @user || @admin
    content = link_to raw('<i class="fa fa-trash"></i>'),
              topic_path(@topic), method: :delete, 'data-confirm': '确认删除吗？',
              "data-toggle" => "tooltip", "data-placement" => "top", title: "删除话题"
    if opts[:label] == false
      raw(content)
    else
      raw(content_tag("li", content))
    end
  end

  def user_admin?
    @admin = current_user && current_user.admin?
  end

  def topic_belong_to_user?
    @user = current_user && current_user.id == @topic.user_id
  end
end
