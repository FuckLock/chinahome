class User
  module Actionable
    extend ActiveSupport::Concern

    included do
      action_plugin :User, :block, :Node
      action_plugin :User, :like, :Topic
    end

  end
end
