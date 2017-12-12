class Setting < RailsSettings::Base
  source Rails.root.join("config/config.yml")
  namespace Rails.env
  SEPARATOR_REGEXP = /[\s,]/
  KEYS_IN_ADMIN = %w[
    custom_head_html
    navbar_html
    navbar_brand_html
    footer_html
    index_html
    wiki_index_html
    wiki_sidebar_html
    site_index_html
    topic_index_sidebar_html
    after_topic_html
    before_topic_html
    node_ids_hide_in_topics_index
    reject_newbie_reply_in_the_evening
    newbie_limit_time
    ban_words_on_reply
    newbie_notices
    tips
    apns_pem
    blacklist_ips
    admin_emails
    ban_reasons
  ]

  class << self
    def has_module?(name)
      return true if self.modules.blank? || self.modules == "all"
      self.module_list.include? name.to_s
    end

    def module_list
      self.modules.split(SEPARATOR_REGEXP)
    end

    # def sso_enabled?
    #   return false if self.sso_provider_enabled?
    #   self.sso["enable"] == true
    # end

    # def sso_provider_enabled?
    #   self.sso["enable_provider"] == true
    # end

    def has_admin?(email)
      return false if self.admin_emails.blank?
      self.admin_emails.split(SEPARATOR_REGEXP).include?(email)
    end
  end
end
