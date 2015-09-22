$ = require 'jquery'
Backbone = require 'backbone'
jsonTemplate = require '../templates/json.hbs'
ProductsContainer = require './ProductsContainer.coffee'

class WidgetContainer extends Backbone.View
  template: require '../templates/widget_container.hbs'

  initialize: (options)->
    @widget_configuration = options.conf
    @product_id = options.product_id
    @products = options.model
    @

  render: ->
    @_extractModelData()
    if @template
      @setElement @template @_getTemplateData()
      @_appendTitle()
      @$el.addClass '' # Add hidden class since we'll be making transition-in to visible
    for row in @rows
      products_container = new ProductsContainer
        model: row
        product_id: @product_id
        widget_configuration: @widget_configuration
      @$el.append products_container.render().el
    @_finishImpression()
    super
    @

  _finishImpression: ->
    # make api call
    headers = {}
    headers.apikey = @widget_configuration.apikey

    $.ajax
      method: "POST",
      url: "http://api.wide-eyes.it/widget/impressions",
      data: '{}'
      dataType: 'json'
      contentType: 'application/json; charset=UTF-8'
      headers:
        headers
      crossDomain: true
      processData: false
      error: (error) =>
        console.warn(error)
      success: (response)=>

  _appendTitle: () ->
    h2 = document.createElement 'h2'
    if @widget_configuration.type.title.text
      h2.innerHTML = config.type.title.text
    else
      h2.innerHTMl = "Similar products"
    @$el.append h2
    @

  show: (callback = ->) ->
    callback()

  hide: (callback = ->) ->
    callback()

  _extractModelData: ->
    results = @products
    parsed_results = @_parseVisionResults results

    elmsPerRow = config.layout.minColumnCount || 4
    parsed_results = @_chunkData parsed_results, elmsPerRow
    @rows = parsed_results

  _chunkData: (arr, size) ->
    newArr = []
    for item, i in arr by size
      newArr.push (arr.slice i, i+size)
    newArr

  # Get the array of results from the api results
  _parseVisionResults: (results) ->
    list = []
    i = 0
    while i < results.result_both.length
      if i >= @widget_configuration.layout.numOfElms
        break
      list = list.concat(results.result_both[i])
      i++

    # if empty then the shape array
    if results.result_both.length == 0
      i = 0
      while i < results.result_shape.length
        if i >= @widget_configuration.layout.numOfElms
          break
        list = list.concat(results.result_shape[i])
        i++

    # if empty then the color array
    if results.result_both.length == 0 and results.result_shape.length == 0
      i = 0
      while i < results.result_color.length
        if i >= @widget_configuration.layout.numOfElms
          break
        list = list.concat(results.result_color[i])
        i++
    list = @_filterTileContent(list)
    list

  _filterTileContent: (list) ->
    i = 0
    while i < list.length
      if !config.tile.hasTitle
        delete list[i].ProductName
      if (typeof(list[i].ProductCustomData)=="string")
        if (list[i].ProductCustomData == '')
          list[i].ProductCustomData = ''
        else
          list[i].ProductCustomData = JSON.parse(list[i].ProductCustomData)
          if !config.tile.hasDescription
             delete list[i].ProductCustomData.description
          if !config.tile.hasPrice
            delete list[i].ProductCustomData.price
          else
            list[i].ProductCustomData.price = list[i].ProductCustomData.price.toFixed(2)
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
    {products : @rows}


module.exports = WidgetContainer