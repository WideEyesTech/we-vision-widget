define (require) ->

  $ = require 'jquery'
  _ = require 'underscore'
  Backbone = require 'backbone'
  Handlebars = require 'handlebars.runtime'
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
      if config and config.mode and config.mode == 'debug'
        console.time("WideEyesWidget")
      
      _.bindAll @
      @render()

    render: ->
      $(config.widgetPositionAfter).prepend @el
      widget_container = new WidgetContainer
        model: products
        product_id: product_id
        conf: config
      @$el.append widget_container.render().el
      widget_container.show()
      @_applyStyling()
      @

    _applyStyling: -> 
      if config.layout.isCentered
        $('.grid').css('margin', '0 auto')
      if config.type
        @_insertTypeStyles()
      if config.layout.columnCount
        @_applyCustomLayout(config.layout.columnCount)

    _applyCustomLayout: (colCount) ->
      style = document.getElementsByTagName 'style'
      styleSheet = style[0].sheet 
      $('.card').addClass 'col-xs-1-'+config.layout.mobileColumnCount
      
      # 8 COLUMNS
      if colCount == 8 
        $('.card').addClass 'col-sm-1-2 col-md-1-4 col-lg-1-8'
        $('.grid').css('max-width', '1600px')
        cardRule = '
        .card {
          height: 300px;
        }'
        imgRule= '.image-container img {
          max-height: 220px;
        }'
        mediaRule = '
        @media (min-width: 1024px) 
          {
            .card {
              height: auto;
            }
            .image-container img {
              max-height: none;
            }
          }'
        styleSheet.insertRule mediaRule,0
        styleSheet.insertRule cardRule,0
        styleSheet.insertRule imgRule,0
      
      # 4 COLUMNS
      else if colCount == 4
        $('.card').addClass 'col-sm-1-2 col-md-1-4'
        $('.grid').css('max-width', '1024px')
        cardRule = '
        .card {
          height: 300px;
        }'
        imgRule = '.image-container img {
          max-height: 220px;
        }'
        mediaRule = '
        @media (min-width: 768px) 
          {
            .card {
              height: auto;
            }
            .image-container img{
              max-height: none;
            }
          }'
        styleSheet.insertRule mediaRule,0
        styleSheet.insertRule cardRule,0
        styleSheet.insertRule imgRule,0
      
      # 2 COLUMNS
      else if colCount == 2
        $('.card').addClass ' col-sm-1-2'
        $('.grid').css('max-width', '768px')
        cardRule = '
        .card {
          height: 300px;
        }'
        imgRule = '.image-container img {
          max-height: 220px;
        }'
        mediaRule = '
        @media (min-width: 550px) 
          {
            .card {
              height: auto;
            }
            .image-container img {
              max-height: none;
            }
          }'
        styleSheet.insertRule mediaRule,0
        styleSheet.insertRule cardRule,0
        styleSheet.insertRule imgRule,0
      
      # 1 COLUMN
      else if colCount == 1
        $('.card').addClass ' col-sm-1-1'
        $('.grid').css('max-width', '550px')
      
      # DEFAULT
      else
        $('.card').addClass ' col-sm-1-2 col-md-1-4'
        $('.grid').css('max-width', '1024px')
        cardRule = '
        .card {
          height: 300px;
        }'
        imgRule = '.image-container img {
          max-height: 220px;
        }'
        mediaRule = '
        @media (min-width: 768px) 
          {
            .card {
              height: auto;
            }
            .image-container img{
              max-height: none;
            }
          }'
        styleSheet.insertRule mediaRule,0
        styleSheet.insertRule cardRule,0
        styleSheet.insertRule imgRule,0


    # FONT STYLES
    _insertTypeStyles: -> 
      style = document.createElement 'style'
      document.head.appendChild style
      styleSheet = style.sheet
      
      # font styling
      configType = if config.type then config.type else null
      fontFamily = if configType and configType['font-family'] then configType['font-family'] else ''
      fontSize = if configType and configType['font-size'] then configType['font-size'] else ''
      fontColor = if configType and configType['color'] then configType['color'] else ''

      typeRule = '
      body {
        font-family: '+fontFamily+';
        font-size: '+fontSize+'px;
        color: '+fontColor+';
      }'
      
      styleSheet.insertRule typeRule, 0
      
      # TODO... @font-face 
      # configFontFace = if configType['font-face'] then configType['font-face'] else null
      # fontFaceName = if configFontFace.name then configFontFace.name else ''
      # fontFaceUrl = if configFontFace.url then configFontFace.url else ''
      
      # fontFaceRule = "
      # @font-face {
      #   font-family: "+fontFaceName+";
      #   src: url("+fontFaceUrl+"); 
      # }"

      # styleSheet.insertRule fontFaceRule, 0