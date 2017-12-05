# @Author: baodongdong
# @Date:   2017-11-19T10:17:27+08:00
# @Last modified by:   baodongdong
# @Last modified time: 2017-11-19T15:18:26+08:00

# RailsSettings Model
class Setting < RailsSettings::Base
  source Rails.root.join("config/config.yml")
  namespace Rails.env
  SEPARATOR_REGEXP = /[\s,]/

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
  end
end
