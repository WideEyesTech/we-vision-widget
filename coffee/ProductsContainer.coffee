define (require) ->

  Backbone = require 'backbone'
  $ = require 'jquery'
  _ = require 'underscore'
  ProductContainer = require 'ProductContainer'

  class ProductsContainer extends Backbone.View
    template: require 'templates/products_container'

    events:
      'click': '_onClick'

    initialize: (options)->
      @widget_configuration = options.widget_configuration
      @product_id = options.product_id
      @

    render: ->
      if @template
        @setElement @template @_getTemplateData()
        @$el.addClass '' # Add hidden class since we'll be making transition-in to visible
      for product, index in @model
        prc = new ProductContainer
          model: product
          product_id: @product_id
          widget_configuration: @widget_configuration
        @$el.append prc.render().el
      super
      @
      
    _onClick: ->
      # call statistics/registerClick
      # alert('element clicked');
      true
        
    _getTemplateData: ->
      {products: @model}      