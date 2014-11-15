# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    `this.listenTo(this.get('playerHand'), 'stand', this.stand);
    this.listenTo(this.get('playerHand'), 'bust', this.roundOver);
    this.listenTo(this.get('dealerHand'), 'bust', this.roundOver);
     // this.on('bust', this.bust, this);`
    @

  stand: (playerHand) ->
    dealerHand = @get 'dealerHand'
    console.log('heard stand event from handmodel')
    dealerHand.models[0].set 'revealed', true
    while dealerHand.maxScore() < 17
      dealerHand.hit()
    @roundOverTest()
    @

  roundOverTest: (hand) ->
    # only called on stand
    console.log('heard bust event from handmodel')
    dealerHand = @get 'dealerHand'
    playerHand = @get 'playerHand'
#    console.log(dealerHand.maxScore())
    dealerScore = dealerHand.maxScore()
    playerScore = playerHand.maxScore()
    if playerScore < dealerScore || playerScore > 21
      @roundOver(['You', 'Dealer', dealerScore])
    else if playerScore > dealerScore || dealerScore > 21
      @roundOver(['Dealer', 'You', playerScore])


  roundOver: (arr) ->
#    console.log('round is over, this is what we got:', arr)
    @newHand(arr)

  newHand: (arr) ->
#    console.log('triggering newHand', @)
    @set('playerHand', @get('deck').dealPlayer())
    @set('dealerHand', @get('deck').dealDealer())
#    console.log('round is over, this is what we got:', arr)
    @trigger('displayWinner', arr)
    @
