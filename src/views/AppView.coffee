class window.AppView extends Backbone.View
  model: App

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">        Stand</button> <button class="deal-button">Deal New Hand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .deal-button': -> @render()

  initialize: ->
    that = @
    @.model.on 'displayWinner', (endArr) ->
      console.log('appview heard a displayWinner event', endArr)
      _.delay(that.displayWinner, 800, endArr)
    @render()

  displayWinner: (arr) ->
    alert(arr[1] + ' won!')

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

