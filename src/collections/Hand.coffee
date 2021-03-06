class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())

  stand: ->
    console.log('triggered stand event')
    @trigger('stand', @)
    @

  bustTest: (card) ->
    score = card.collection.maxScore();
    console.log('bustTest called from handview, score is', score)
#    console.log('on add, ' + handOwner + '\'s hand is:', score)
    if score > 21
      # buster, winner, card
      @trigger('bust', card)
    @

  hasAce: ->
    @reduce (memo, card) ->
      if card.get('revealed') is false
        `return memo`
      memo or card.get('value') is 1
    , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  maxScore: ->
    scores = @scores()
    if scores[1] <= 21 && scores[1] > scores[0]
      scores[1]
    else
      scores[0]

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


