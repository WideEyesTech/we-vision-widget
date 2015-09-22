Backbone = require 'backbone'
ProductContainer = require './ProductContainer.coffee'

class ProductsContainer extends Backbone.View
  template: require '../templates/products_container.hbs'

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

  _getTemplateData: ->
    {products: @model}

module.exports = ProductsContainer