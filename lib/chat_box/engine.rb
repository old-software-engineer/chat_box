require "rails/engine"
module ChatBox
  class Engine < ::Rails::Engine
    isolate_namespace ChatBox
    initializer 'local_helper.action_controller' do
      ActiveSupport.on_load :action_controller do
        helper ChatBox::ApplicationHelper
      end
    end
  end
end