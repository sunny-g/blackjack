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
    `
#    @get('playerHand').on('all', @playerEvents, @)
    @

#  playerEvents: ->
#    @

  stand: (playerHand) ->
    dealerHand = @get 'dealerHand'
    console.log('heard stand event from handmodel')
    dealerHand.models[0].set 'revealed', true
    while dealerHand.maxScore() < 17
      dealerHand.hit()
    @roundOver()
    @

  roundOver: (hand) ->
    # only called on stand
    console.log('heard bust event from handmodel')
    dealerHand = @get 'dealerHand'
    playerHand = @get 'playerHand'
    dealerHand.models[0].set 'revealed', true
    dealerScore = dealerHand.maxScore()
    playerScore = playerHand.maxScore()
    if  playerScore > 21
      @newHand(['Dealer won!', dealerScore])
    else if dealerScore > 21
      @newHand(['You won!', playerScore])
    else if playerScore > dealerScore
      @newHand(['You won!', playerScore])
    else if dealerScore > playerScore
      @newHand(['Dealer won!', dealerScore])
    else
#      console.log('there was a tie, INSERT BETTER CODE HERE')
      @newHand(['Push!', playerScore])
    @

  newHand: (arr) ->
    @set('playerHand', @get('deck').dealPlayer())
    @set('dealerHand', @get('deck').dealDealer())
    that = @
    `that.listenTo(that.get('playerHand'), 'stand', that.stand);
    that.listenTo(that.get('playerHand'), 'bust', that.roundOver);
    that.listenTo(that.get('dealerHand'), 'bust', that.roundOver);
    `
    console.log('newHand(), this is what we got:', arr)
    @trigger('displayWinner', arr)
    @
