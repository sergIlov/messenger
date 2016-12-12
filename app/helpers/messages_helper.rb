module MessagesHelper
  def messages_react_params(messages)
    return {} if messages.empty?
    messages_params = messages.map do |message|
      { id: message.id,
        sender: message.sender.email,
        created_at: I18n.l(message.created_at, format: :short),
        text: message.text,
        type: current_user == message.sender ? 'outgoing' : 'incoming',
        is_read: message.is_read?,
        mark_read_path: mark_read_conversation_message_path(message.conversation, message)
      }
    end
    
    react_params = { messages: messages_params,
                     reply: false,
                     load_more_path: conversation_messages_path(params[:conversation_id], oldest_id: messages.last.id, format: :json),
                     load_new_path: conversation_messages_path(params[:conversation_id], last_id: messages.first.id, format: :json),
                     create_message_path: conversation_messages_path(params[:conversation_id], last_id: messages.first.id, format: :json)}
    react_params.deep_transform_keys! { |c| c.to_s.camelcase(:lower).to_sym }
  end
end
