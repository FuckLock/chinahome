module ApplicationHelper
  EMPTY_STRING = "".freeze

  def render_list_items(list = [])
    yield(list) if block_given?
    items = []
    list.each do |link|
      item_class = EMPTY_STRING
      urls = link.match(/href=(["'])(.*?)(\1)/) || []
      url  = urls.length > 2 ? urls[2] : nextWhenVisible
      if url && current_page?(url) || (@current && @current.include?(url))
        item_class = "active"
      end
      items << content_tag("li", raw(link), class: item_class)
    end
    raw items.join(EMPTY_STRING)
  end

  def title_tag(str)
    content_for :title, raw(str.to_s)
  end

  def notice_message
    flash_messages = []
    flash.each do |type, message|
      type = :success if type.to_sym == :notice
      type = :danger if type.to_sym == :alert
      text = content_tag("div", button_tag(raw('<span aria-hidden="true">&times;</span>'), type: "button", class: "close", "data-dismiss" => "alert") + message, class: "alert alert-#{type}")
      flash_messages << text if message
    end
    raw(flash_messages.join("\n"))
  end
end
