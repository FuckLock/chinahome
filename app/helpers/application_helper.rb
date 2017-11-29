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

end
