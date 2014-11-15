class window.AppView extends Backbone.View
  model: App

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    that = @
    @.model.on 'newHand', (e) ->
      console.log('appview heard a newHand event', e)
      that.render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html('')
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

