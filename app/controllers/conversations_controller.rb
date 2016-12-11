class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations.includes(:first_user, :second_user)
    @new_messages = current_user.incoming_messages.unreaded
  end
  
  def new
    @conversation = Conversation.new
  end
  
  def create
    second_user = User.find(params[:conversation][:second_user_id]) rescue nil
    @conversation = Conversation.for_users(current_user, second_user)
    
    if @conversation.persisted?
      redirect_to conversation_messages_path(@conversation)
    else
      render :new
    end
  end
end
