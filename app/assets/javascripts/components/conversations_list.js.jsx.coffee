@ConversationsList = React.createClass
  getInitialState: ->
    conversations: @props.conversations
    loadMorePath: @props.loadMorePath
    loading: false
    totalCount: @props.totalCount

  handleLoadMoreClick: (event) ->
    @setState loading: true
    $.get @state.loadMorePath, (data) =>
      @setState
        conversations: @state.conversations.concat data.conversations
        loadMorePath: data.loadMorePath
        loading: false
        totalCount: data.totalCount

  isSomethingToLoad: ->
    @state.conversations.length < @state.totalCount

  actions: ->
    if @isSomethingToLoad()
      `<div className="btn-group">
        <button className="btn btn-default" disabled={this.state.loading} onClick={this.handleLoadMoreClick}>load more</button>
      </div>`
    else
      ''

  getConversations: ->
    @state.conversations.map (conversation) ->
      `<ConversationsListRow key={conversation.id} conversation={conversation}/>`

  render: ->
    `<div>
      <div className="list-group">{this.getConversations()}</div>
      {this.actions()}
    </div>`
