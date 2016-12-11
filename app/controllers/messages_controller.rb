class MessagesController < ApplicationController
  def index
    @conversation = current_user.conversations.find(params[:conversation_id])
    @messages = @conversation.messages
  end
  
  def create
    conversation = current_user.conversations.find(params[:conversation_id])
    receiver = conversation.companion(current_user)
    message = Message.new(permitted_params.merge(sender: current_user, receiver: receiver))
    conversation.messages << message
    redirect_to conversation_messages_path(params[:conversation_id])
  end
  
  def mark_read
    message = Message.find(params[:id])
    message.update_attributes(is_read: true)
    render json: { success: true }
  end
  
  def permitted_params
    params.require(:message).permit(:text)
  end
end
