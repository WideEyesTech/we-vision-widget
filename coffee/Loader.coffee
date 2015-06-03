define (require) ->

  $ = require 'jquery'
  _ = require 'underscore'
  Backbone = require 'backbone'
  Handlebars = require 'handlebars.runtime'
  style = require 'templates/style'
  WidgetContainer = require 'WidgetContainer'
  WeSaas = require 'WeSaas'
  Handlebars.registerHelper 'equals', (lvalue, rvalue, options) ->
    if arguments.length < 3
      throw new Error('Handlebars Helper equal needs 2 parameters')
    if lvalue != rvalue
      options.inverse this
    else
      options.fn this

  Handlebars.partials = Handlebars.templates

  class Loader extends Backbone.View

    className: 'we-widget-loader'

    initialize: ->
      if window.wide_eyes_config
        if window.wide_eyes_config.mode
          if window.wide_eyes_config.mode == 'debug'
            console.time("WideEyesWidget")
      
      _.bindAll @
      $('head').append style()  # append the css to the head section
      @we_saas = new WeSaas
      
      if window.wide_eyes_config
          #####
          # Get the product_id
          #####
          wide_eyes_product_id = null
          if (window.wide_eyes_product_id)
            wide_eyes_product_id = window.wide_eyes_product_id
          else
            return
          #####
          #####
          #####
          @wide_eyes_product_id = wide_eyes_product_id
          api_key = window.wide_eyes_config.apikey
          headers = {}
          headers.apikey = api_key
          if (window.wide_eyes_config.apikey)
            headers.apikey = window.wide_eyes_config.apikey
          #----------
          data = { ProductId: wide_eyes_product_id }

          @we_saas.fetch
            data: JSON.stringify(data)
            dataType: 'json'
            contentType: 'application/json; charset=UTF-8'
            headers: 
              headers
            type: 'POST'
            crossDomain: true
            processData: false
            error: (error) =>
              console.log(error)
            success: (data) =>
              if data.attributes.success
                _.defer @render 
          

    render: ->
      $(window.wide_eyes_config.widgetPositionAfter).prepend @el
      widget_container = new WidgetContainer
        model: @we_saas
        product_id: @wide_eyes_product_id
        conf: window.wide_eyes_config
      @$el.append widget_container.render().el
      widget_container.show()
      @
