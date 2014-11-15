class window.CardView extends Backbone.View
  className: 'card'

  # template: _.template '<%= rankName %> of <%= suitName %>'
  template: _.template '<img src="img/cards/<%=rankName%>-<%=suitName%>.png"/>'
  # template: _.template '<img src="img/cards/2-spades.png"/>'

  initialize: ->
    @render().$el.fadeIn(800)

  render: ->
    @$el.children().detach()
    if @model.attributes.revealed is false
      @$el.addClass 'covered'
      @$el.html '<img src="img/card-back.png"/>'
    else
      @$el.html @template @model.attributes
    @

