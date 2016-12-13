@MessagesList = React.createClass
  getMessages: ->
    reply = @props.recent
    if @props.messages.length
      @props.messages.map (message) ->
        `<Message key={message.id} message={message} reply={reply}/>`
    else
      'You dont have new messages'

  render: ->
    `<div className="list-group">
      {this.getMessages()}
    </div>`
