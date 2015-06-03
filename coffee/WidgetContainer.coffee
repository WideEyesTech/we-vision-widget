define (require) ->

  Backbone = require 'backbone'
  jsonTemplate = require 'templates/json'
  ProductsContainer = require 'ProductsContainer'
  _ = require 'underscore'

  class WidgetContainer extends Backbone.View
    template: require 'templates/widget_container'

    initialize: (options)->
      _.bindAll @
      @widget_configuration = options.conf
      @product_id = options.product_id
      @

    render: ->
      @_extractModelData()
      if @template
        @setElement @template @_getTemplateData()
        @$el.addClass '' # Add hidden class since we'll be making transition-in to visible
      products_container = new ProductsContainer
        model: @products
        product_id: @product_id
        widget_configuration: @widget_configuration
      @$el.append products_container.render().el
      
      super
      @
      
    show: (callback = ->) ->
      callback()
          
    hide: (callback = ->) ->
      callback()
      
    _extractModelData: ->
      results = @_filterProductFromVisionResults(@model.toJSON(), @product_id)
      parsed_results = @_parseVisionResults(results)
      for element,index in parsed_results
        if element.ProductCustomData != ''
          if element.ProductCustomData.price
            element.ProductCustomData.price = element.ProductCustomData.price.toFixed(2)
          if (element.ProductCustomData.original_image)
            element.ImgUrls[0] = element.ProductCustomData.original_image
      @products = parsed_results
      
    # Get the array of results from the api results
    _parseVisionResults: (results) ->
      list = []
      i = 0
      while i < results.result_both.length
        if i >= @widget_configuration.numberOfElements
          break
        list = list.concat(results.result_both[i])
        i++
      if results.result_both.length == 0
        # if empty then the shape array
        i = 0
        while i < results.result_shape.length
          if i >= @widget_configuration.numberOfElements
            break
          list = list.concat(results.result_shape[i])
          i++
      if results.result_both.length == 0 and results.result_shape.length == 0
        # if empty then the color array
        i = 0
        while i < results.result_color.length
          if i >= @widget_configuration.numberOfElements
            break
          list = list.concat(results.result_color[i])
          i++
      i = 0
      while i < list.length
        if (typeof(list[i].ProductCustomData)=="string")
          if (list[i].ProductCustomData == '')
            list[i].ProductCustomData = ''
          else
            list[i].ProductCustomData = JSON.parse(list[i].ProductCustomData) 
        i++
      list
      
    _filterProductFromVisionResults: (results, productId) ->
      res = {}
      res.result_both = results.result_both.filter( (val,indx,arr_obj) ->
        if (val.ProductId == productId)
          return false
        else 
          return true
      )
      res.result_shape = results.result_shape.filter( (val,indx,arr_obj) -> 
        if (val.ProductId == productId)
          return false
        else 
          return true
      )
      res.result_color = results.result_color.filter( (val,indx,arr_obj) ->
        if (val.ProductId == productId)
          return false
        else 
          return true
      )
      res

    _getTemplateData: ->
      {products: @products}
