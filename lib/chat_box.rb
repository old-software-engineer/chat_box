require 'chat_box/engine'
require "chat_box/user_chat"
require "active_support/dependencies"
require 'byebug'

module ChatBox
  # Our host application root path
  # We set this when the engine is initialized
  mattr_accessor :author_class
  # Yield self on setup for nice config blocks

	def self.author_class
	  @@author_class.classify.constantize
	end

  def self.setup
    yield self
  end
end
