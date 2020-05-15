require 'chat_box/engine'
require "active_support/dependencies"
# require "../app/controllers/chat_box/conversations_controller"
# require "../config/routes"
# require "chat_box/helpers"
# require "conversations/controllers"
module ChatBox
  # Our host application root path
  # We set this when the engine is initialized
  mattr_accessor :app_root

  # Yield self on setup for nice config blocks
  def self.setup
    yield self
  end
end
