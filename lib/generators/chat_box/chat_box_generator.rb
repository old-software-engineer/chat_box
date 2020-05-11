require 'rails/generators/migration'
require 'rails/generators/active_record'

class ChatBoxGenerator<ActiveRecord::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  def copying
    puts "I'm working"
    copy_file "chat_box.css","app/assets/stylesheets/chat_box.css"
    copy_file "chat_box.js.erb","app/assets/javascripts/chat_box.js.erb"
    copy_file "_chat_box.html.erb","app/views/chat_box/_chat_box.html.erb"
  end
end