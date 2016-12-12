class ConversationsController < ApplicationController
  include ConversationsHelper
  
  def index
    @conversations = load_conversations
    respond_to do |format|
      format.html { @new_messages = current_user.incoming_messages.unreaded }
      format.json { render json: conversations_list_react_params(@conversations) }
    end
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
  
  private
  
  def load_conversations
    current_user.conversations.includes(:first_user, :second_user).offset(params[:offset].to_i).order(updated_at: :desc).limit(10)
  end
end
