@MessageForm = React.createClass
  getInitialState: ->
    path: @props.path

  handleSubmitClick: ->
    text = $(@nessageTextarea).val()
    if text.length
      $.post @state.path, { text: text }, (data) =>
        @props.onNewMessage(data)
        $(@nessageTextarea).val('')
    else
      alert('Message cannot be empty')


  render: ->
    `<div className="form-group">
      <div className="from-group">
        <textarea className="form-control" ref={ (textarea) => { this.nessageTextarea = textarea } }></textarea>
      </div>
      <button className="btn btn-default" onClick={this.handleSubmitClick}>Send</button>
    </div>`