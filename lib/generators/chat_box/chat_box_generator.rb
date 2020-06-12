require "rails/generators/base"
require "rails/generators/active_record"
require "rails/generators/migration"

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

  def model_name
    model_name = args.first
    raise "rails g chat_box model_name(give the model name as a params)" if model_name.nil?
    return model_name
  end

  def create_chat_initializer
    create_file "config/initializers/chat_box.rb","#This model name is used for conversation\nChatBox.author_class = '#{model_name.to_s}'"
  end

  def inject_chat_into_user_model
    file = "app/models/#{model_name}.rb"
    raise "Model error #{model_name.classify} does not exist" unless File.exist?(file)
    raise "Devise Gem is not integrated with #{model_name} model" unless model_name.classify.constantize.devise_modules?
    after = "class #{model_name.classify} < ApplicationRecord\n"
    inject_into_file file, after: after do
      "include ChatBox::UserChat\n"
    end

  end

  def add_helper
    file = "app/controllers/application_controller.rb"
    after = "class ApplicationController < ActionController::Base\n"
    inject_into_file file, after: after do
      "helper ChatBox::Engine.helpers\n"
    end
  end

  def create_migration_file
    model_name = args.first
    migration_template 'user_migration.rb', "db/migrate/add_last_seen_at_to_#{model_name}.rb", migration_version: migration_version,name: model_name
    migration_template 'conversations_migration.rb', 'db/migrate/create_conversations_table.rb', migration_version: migration_version
    migration_template 'messages_migration.rb', 'db/migrate/create_messages_table.rb', migration_version: migration_version
  end


  def channel_current_user
    file = "app/channels/application_cable/connection.rb"
    raise "file required #{file}" unless File.exist?(file)
    after = "Connection < ActionCable::Connection::Base\n"
    inject_into_file file, after: after do
      "   identified_by :current_user
          def connect
            self.current_user = find_verified_user
          end

          protected

          def find_verified_user
            if (current_user = env['warden'].user)
              current_user
            else
              reject_unauthorized_connection
            end
          end\n"
    end
  end

   def add_chat_route
     route "mount ChatBox::Engine => \"/chat_box\", as: \"chat_box\""
   end
  #

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