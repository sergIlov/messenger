# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Message
  constructor: (@control) ->
    @control.on 'mouseover', @onMouseover

  onMouseover: =>
    if @control.data('message-params-new')
      console.debug('send')
      $.post @control.data('message-params-url'), {}, =>
        @control.removeClass('list-group-item-info')
        @control.data('message-params-new', false)

jQuery ->
  $('[data-message]').each ->
    new Message($(this))