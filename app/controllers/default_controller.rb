class DefaultController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @new_messages_count = current_user.incoming_messages.unread.count
  end
end
