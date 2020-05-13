require "rails/engine"
module ChatBox
  class Engine < ::Rails::Engine
    isolate_namespace ChatBox
  end
end