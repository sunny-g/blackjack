# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    `this.listenTo(this.get('playerHand'), 'stand', this.stand);
    this.listenTo(this.get('playerHand'), 'roundOver', this.roundOver);
    this.listenTo(this.get('dealerHand'), 'roundOver', this.roundOver);
     // this.on('bust', this.bust, this);`
    @

  stand: (playerHand) ->
    dealerHand = @get 'dealerHand'
    playerHand = @get 'playerHand'
    console.log('heard stand event from handmodel')
    dealerHand.models[0].set 'revealed', true
    while dealerHand.maxScore() < 17
      dealerHand.hit()
    @

  roundOver: (arr) ->
    # needs to trigger AppView
    alert(arr[1] + ' won!')
    @newHand()

  newHand: ->
    console.log('triggering newHand', @)
    @trigger('newHand', @)
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @
