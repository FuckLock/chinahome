class User
  module Actionable
    extend ActiveSupport::Concern

    included do
      action_plugin :User, :block, :Node
      action_plugin :User, :like, :Topic
      action_plugin :User, :collect, :Topic
    end
  end
end
