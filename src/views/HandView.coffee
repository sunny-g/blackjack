class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> : <span class="score"></span></h2>'

  initialize: ->
    # @collection.on 'add remove change', => @render
    `var that = this;
    this.collection.on('add remove', function(card) {
      that.renderNewCard(card);
      that.collection.bustTest(card);
    }, this);
    `

    @collection.on 'change', => @render()
    # @collection.on 'stand', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @renderScore()
    @

  renderNewCard: (card) ->
    @$el.append new CardView(model: card).$el
    @renderScore()
#    callback.call(@.collection, card)
    @

  renderScore: ->
    that = @
    @$('.score').text ->
      hand = that.collection
      # console.log(scores)
      if hand.minScore() != hand.maxScore()
        '' + hand.minScore() + ' (' + hand.maxScore() + ')'
      else
        '' + hand.minScore()
      # that.collection.maxScore()
    @

