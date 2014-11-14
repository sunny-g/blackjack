# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

#   @get 'playerHand' on 'stand', ->
#     console.log('heard stand event from handmodel')
    `this.listenTo(this.get('playerHand'), 'stand', this.stand);`

    @

  stand: (playerHand) ->

    dealerHand = @get 'dealerHand'
    console.log('heard stand event from handmodel')
    dealerHand.models[0].set 'revealed', true
    while dealerHand.maxScore() < 15
      # insert some animation to make dealing cards not so instantaneous
      dealerHand.hit()
    
    @

