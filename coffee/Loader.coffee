define (require) ->

  $ = require 'jquery'
  _ = require 'underscore'
  Backbone = require 'backbone'
  Handlebars = require 'handlebars.runtime'
  Event = require 'Event'
  Magnifier = require 'Magnifier'
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

    className: 'we-vision-loader'

    initialize: ->
      if config and config.mode and config.mode == 'debug'
        console.time("WideEyesWidget")

      _.bindAll @
      @render()

    render: ->
      $("#widget").prepend @el
      widget_container = new WidgetContainer
        model: products
        product_id: product_id
        conf: config
      @$el.append widget_container.render().el
      widget_container.show()
      @_applyStyling()
      if config.image.magnifier
        # evt = new Event
        # m = new Magnifier evt
        # m.attach {
        #   thumb: ".productsImage",
        #   mode: 'inside',
        #   zoomable: true
        # }
        @_activateMagnifier()
      @

    _activateMagnifier: () ->
      evt = new Event
      m = new Magnifier evt
      m.attach {
        thumb: ".productsImage",
        largeWrapper: 'preview',
        zoomable: true
      }
      prev = $('#preview')
      $(window).mousemove (event) ->
        event = event or window.event
        if event.pageX == null and event.clientX != null
          eventDoc = event.target and event.target.ownerDocument or document
          doc = eventDoc.documentElement
          body = eventDoc.body
          event.pageX = event.clientX + (doc and doc.scrollLeft or body and body.scrollLeft or 0) - (doc and doc.clientLeft or body and body.clientLeft or 0)
          event.pageY = event.clientY + (doc and doc.scrollTop or body and body.scrollTop or 0) - (doc and doc.clientTop or body and body.clientTop or 0)
        prev.offset {top: event.pageY, left: event.pageX - prev.width() / 2}

    _applyStyling: ->
      style = document.createElement 'style'
      document.head.appendChild style
      @styleSheet = style.sheet

      if config.type
        @_insertTypeStyles()
      if config.layout.isCentered
        $('.grid').css('margin', '0 auto')
      if config.layout.minColumnCount
        @_applyCustomLayout(config.layout.minColumnCount, config.layout.responsize)
      if config.image
        @_applyCustomImageStyling()

    _applyCustomImageStyling: () ->
      maxWidth = if config.image["max-width"] then config.image["max-width"] else ''
      maxHeight = if config.image["max-height"] then config.image["max-height"] else ''
      imgSizeRule = '
      .card .image-container img {
        max-width: ' + maxWidth + 'px;
        max-height: ' + maxHeight + 'px;
      }'
      @styleSheet.insertRule imgSizeRule, @styleSheet.cssRules.length - 1

    _applyCustomLayout: (colCount, responsive) ->
      # 8 COLUMNS
      if colCount == 8
        $('.card').addClass 'col-xs-1-8'
        $('.grid').css('max-width', '1600px')
      # 5 COLUMNS
      else if colCount == 5
        $('.card').addClass 'col-xs-1-5'
        $('.grid').css('max-width', '1200px')
        if responsive
          $('.card').addClass 'col-lg-8'
      # 4 COLUMNS
      else if colCount == 4
        $('.card').addClass 'col-xs-1-4'
        $('.grid').css('max-width', '1024px')
        if responsive
          $('.card').addClass 'col-lg-8'
      # 2 COLUMNS
      else if colCount == 2
        $('.card').addClass 'col-xs-1-2'
        $('.grid').css('max-width', '768px')
        if responsive
          $('.card').addClass 'col-md-1-4 col-lg-8'
      # 1 COLUMN
      else if colCount == 1
        $('.card').addClass ' col-xs-1-1'
        $('.grid').css('max-width', '550px')
        if responsive
          $('.card').addClass 'col-sm-1-2 col-md-1-4 col-lg-1-8'
      # DEFAULT
      else
        $('.card').addClass 'col-xs-1-1 col-sm-1-2 col-md-1-4'
        $('.grid').css('max-width', '1024px')

    _insertTypeStyles: ->
      type = if config.type then config.type else null
      if not type then return false

      fontFamily = if type['font-family'] then type['font-family'] else ''
      fontSize = if type['font-size'] then type['font-size'] else ''
      fontColor = if type['color'] then type['color'] else ''

      displayHeader = if type.title['display'] then 'block' else 'none'
      letterSpacing = if type.title['letter-spacing'] then type.title['letter-spacing'] else ''
      headerFontSize = if type.title['font-size'] then type.title['font-size'] else ''
      fontWeight = if type.title['font-weight'] then type.title['font-weight'] else ''
      textTransform = if type.title['transform'] then type.title['transform'] else ''

      bodyRule = '
      body {
        font-family: ' + fontFamily + ';
        font-size: ' + fontSize + 'px;
        color: ' + fontColor + ';
      }'
      headerRule = '
      .grid > h2 {
        display: ' + displayHeader + ';
        letter-spacing: ' + letterSpacing + 'em;
        text-transform: ' + textTransform + ';
        font-size: ' + headerFontSize + 'px;
        font-weight: ' + fontWeight + ';
      }'
      @styleSheet.insertRule headerRule, 0
      @styleSheet.insertRule bodyRule, 0

      ff = if type['font-face'] then type['font-face'] else null
      if ff
        ffUrl = if ff.url then ff.url else ''
        if ffUrl.indexOf('http') > -1
          ffRule = "@import '" + ffUrl + "';"
        else
          ffName = if ff.name then ff.name else ''
          ffRule = "
          @font-face {
            font-family: "+ffName+";
            src: url("+ffUrl+");
          }"
        @styleSheet.insertRule ffRule, 0
