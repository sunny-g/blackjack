assert = chai.assert

describe 'deck', ->
  deck = null
  playerHand = null
  dealerHand = null

  beforeEach ->
    deck = new Deck()
    playerHand = deck.dealPlayer()
    dealerHand = deck.dealDealer()

  describe 'hit', ->
    it 'should give the last cards from the deck', ->
      assert.strictEqual deck.length, 48

#  describe 'stand', ->
#    it ''
