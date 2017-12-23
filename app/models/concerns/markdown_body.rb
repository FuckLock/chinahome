module MarkdownBody
  include ActionView::Helpers::OutputSafetyHelper
  include ApplicationHelper

  def body_html
    markdown(body)
  end
end
