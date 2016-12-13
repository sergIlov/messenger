class MessagesController < ApplicationController
  include MessagesHelper

  before_action :authenticate_user!
  
  def index
    @conversation = current_user.conversations.find(params[:conversation_id])
    @messages = load_messages
    respond_to do |format|
      format.html
      format.json { render json: messages_react_params(@messages) }
    end
  end
  
  def unread
    render json: messages_react_params(load_messages, recent: true)
  end
  
  def create
    @conversation = current_user.conversations.find(params[:conversation_id])
    receiver = @conversation.companion(current_user)
    message = Message.new(sender: current_user, receiver: receiver, text: params[:text])
    @conversation.messages << message
    
    render json: messages_react_params(load_messages.reload)
  end
  
  def mark_read
    message = Message.find(params[:id])
    message.update_attributes(is_read: true)
    render json: { success: true }
  end
  
  private
  
  def load_messages
    scope = @conversation.present? ? @conversation.messages : current_user.incoming_messages.includes(:sender).unread
    scope = scope.includes(:sender, :receiver)
    scope = scope.where('id < ?', params[:oldest_id]) if params[:oldest_id].present?
    scope = scope.where('id > ?', params[:last_id]) if params[:last_id].present?
    scope.limit(10)
  end
end
