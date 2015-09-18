Backbone = require 'backbone'
_ = require 'underscore'
$ = require 'jquery'

class ProductContainer extends Backbone.View
  self = this
  template: require '../templates/product_container.hbs'

  events:
    'click a': '_onClick'

  initialize: (options)->
    @config = options.widget_configuration
    @product_id = options.product_id

  render: ->
    if @template
      @setElement @template @_getTemplateData()
      @$el.addClass ''
      if @config.tile.display
        @$el.mouseenter(_onMouseEnter)
        @$el.mouseleave(_onMouseLeave)
    @_finishImpression()
    @

  _finishImpression: ->
    # make api call
    headers = {}
    headers.apikey = @config.apikey

    $.ajax
      method: "POST",
      url: "http://api-mirror.wide-eyes.it/widget/impressions/product",
      data: JSON.stringify({
        page_product_id: @product_id,
        target_product_id: @model.ProductId
      }),
      dataType: 'json'
      contentType: 'application/json; charset=UTF-8'
      headers:
        headers
      crossDomain: true
      processData: false
      error: (error) =>
        console.warn(error)
      success: (response)=>


  _onClick: ->
    # call statistics/registerClick
    headers = {}
    headers.apikey = @config.apikey
    @_genericClickCall(headers)
    @_targetClickCall(@model.ProductId, @product_id, headers)
    @

  _genericClickCall: (headers) ->
    $.ajax
      method: "POST",
      url: "http://api-mirror.wide-eyes.it/widget/clicks",
      data: '{}',
      dataType: 'json'
      contentType: 'application/json; charset=UTF-8'
      headers:
        headers
      crossDomain: true
      processData: false
      error: (error) =>
        console.warn(error)
      success: (response)=>

  _targetClickCall: (targetId, ProductId, headers) ->
    $.ajax
      method: "POST",
      url: "http://api-mirror.wide-eyes.it/widget/clicks/product",
      data: JSON.stringify({
        page_product_id: ProductId,
        target_product_id: targetId
      }),
      dataType: 'json'
      contentType: 'application/json; charset=UTF-8'
      headers:
        headers
      crossDomain: true
      processData: false
      error: (error) =>
        console.warn(error)
      success: (response)=>

  _getTemplateData: ->
    @model

_onMouseLeave = (ev) ->
ev.currentTarget.className = ev.currentTarget.className.replace " hover", ""

_onMouseEnter = (ev) ->
ev.currentTarget.className += " hover"