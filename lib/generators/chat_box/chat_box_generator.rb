require 'rails/generators/migration'
require 'rails/generators/active_record'

class ChatBoxGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end
  # def copying
  #   puts "I'm working"
  #   copy_file "conversations.css","app/assets/stylesheets/conversations.css"
  #   copy_file "conversations.js.erb","app/assets/javascripts/conversations.js.erb"
  #   copy_file "_chat_box.html.erb","app/views/conversations/_chat_box.html.erb"
  # end

  def create_migration_file
    migration_template 'conversations_migration.rb', 'db/migrate/create_conversations_table.rb', migration_version: migration_version
    migration_template 'messages_migration.rb', 'db/migrate/create_messages_table.rb', migration_version: migration_version
  end

  # def inject_chat_into_user_model
  #   file = "app/models/user.rb"
  #   after = "class User < ApplicationRecord\n"
  #   inject_into_file file, after: after do
  #     "has_many :messages\n has_many :conversations, foreign_key: :sender_id\n"
  #   end
  # end

  def rails5?
    Rails.version.start_with? '5'
  end

  def migration_version
    if rails5?
      "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
    end
  end
  private
  def self.next_migration_number(dirname)
    next_migration_number = current_migration_number(dirname) + 1
    ActiveRecord::Migration.next_migration_number(next_migration_number)
  end
end