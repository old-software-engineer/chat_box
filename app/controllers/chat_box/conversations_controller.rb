module ChatBox
  class ConversationsController < ApplicationController
    def create
      @conversation = Conversation.get(current_user.id, params[:user_id])
      add_to_conversations unless conversated?
      respond_to do |format|
        format.js
      end
    end

    def close
      @conversation = Conversation.find(params[:id])
      session[:conversations].delete(@conversation.id)
      respond_to do |format|
        format.js
      end
    end

    def group_modal
      @users = current_user.chat_list
      @group = current_user.groups.new
      respond_to do |format|
        format.js
      end
    end

    def create_group
      if params[:group_id].present?
        @group = Group.find(params[:group_id])
      else
        @group = current_user.groups.create(group_name: params[:group][:group_name],group_ids: JSON.parse(params[:group][:group_ids]))
      end
      
      respond_to do |format|
        format.js
      end
    end

    private

    def add_to_conversations
      session[:conversations] ||= []
      session[:conversations] << @conversation.id
    end

    def conversated?
      session[:conversations] ||= [] if session[:conversations].nil?
      session[:conversations].include?(@conversation.id)
    end
  end
end