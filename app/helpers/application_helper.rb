module ApplicationHelper
  EMPTY_STRING = "".freeze

  LANGUAGES_LISTS = {
    "Ruby"                         => "ruby",
    "HTML / ERB"                   => "erb",
    "CSS / SCSS"                   => "scss",
    "JavaScript"                   => "js",
    "YAML</i>"                     => "yml",
    "CoffeeScript"                 => "coffee",
    "Nginx / Redis <i>(.conf)</i>" => "conf",
    "Python"                       => "python",
    "PHP"                          => "php",
    "Java"                         => "java",
    "Erlang"                       => "erlang",
    "Shell / Bash"                 => "shell"
  }

  def render_list_items(list = [])
    yield(list) if block_given?
    items = []
    list.each do |link|
      items << content_tag("li", raw(link))
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

  def insert_code_menu_items_tag
    lang_list = []
    LANGUAGES_LISTS.each do |k, l|
      lang_list << content_tag(:li, raw(link_to raw(k), "#", data: { lang: l }, class: "dropdown-item insert-codes"))
    end
    raw lang_list.join(EMPTY_STRING)
  end

  def markdown
    return nil if text.blank?
    Rails.cache.fetch(["markdown", Digest::MD5.hexdigest(text)]) do
      sanitize_markdown(Homeland::Markdown.call(text))
    end
  end

  def sanitize_markdown(html)
    raw Sanitize.fragment(html, Homeland::Sanitize::DEFAULT)
  end
end
