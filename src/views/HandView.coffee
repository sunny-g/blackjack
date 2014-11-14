class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> : <span class="score"></span></h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    # @collection.on 'stand', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    that = this
    @$('.score').text ->
      scores = that.collection.scores()
      # console.log(scores)
      if scores[1] != scores[0] && scores[1] <= 21
        '' + scores[0] + ' (' + scores[1] + ')'
      else
        '' + scores[0]
      # that.collection.maxScore()

