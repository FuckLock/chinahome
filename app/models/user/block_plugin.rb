class User
  module BlockPlugin
    extend ActiveSupport::Concern

    included do
      action_plugin :User, :block, :Node
    end

  end
end
