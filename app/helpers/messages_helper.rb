module MessagesHelper
  def message_html_data(message)
    params = {
      url: mark_read_conversation_message_path(message.conversation, message),
      new: message.is_new_for?(current_user).to_s
    }
    { message: true, message_params: params }
  end
  
  def message_class(message)
    unless message.is_read?
      message.is_new_for?(current_user) ? 'list-group-item-info' : 'list-group-item-warning'
    end
  end
end
