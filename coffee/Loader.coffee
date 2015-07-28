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
      if glbWeConfig and glbWeConfig.mode and glbWeConfig.mode == 'debug'
        console.time("WideEyesWidget")

      _.bindAll @
      @render()

    render: (customConfig) ->
      $("#widget .we-widget-loader").empty()
      $("#widget").prepend @el
      widget_container = new WidgetContainer
        model: products
        product_id: product_id
        conf: customConfig || glbWeConfig
      @$el.append widget_container.render().el
      widget_container.show()
      if customConfig
        @_applyStyling(customConfig)
      else
        @_applyStyling(glbWeConfig)
      @

    _applyStyling: (config) ->
      if config.layout.isCentered
        $('.grid').css('margin', '0 auto')
      if config.type
        @_insertTypeStyles(config.type)
      if config.layout.columnCount
        @_applyCustomLayout(config)

    _applyCustomLayout: (config) ->
      style = document.getElementsByTagName 'style'
      styleSheet = style[0].sheet
      $('.card').addClass 'col-xs-1-'+config.layout.mobileColumnCount

      # 8 COLUMNS
      if config.layout.columnCount == 8
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
      else if config.layout.columnCount == 4
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
      else if config.layout.columnCount == 2
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
      else if config.layout.columnCount == 1
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

      if !config.layout.hasTitle
        $('.grid > h2').css('display', 'none');



    # FONT STYLES
    _insertTypeStyles: (type) ->
      style = document.createElement 'style'
      document.head.appendChild style
      styleSheet = style.sheet

      # font styling
      fontFamily = if type and type['font-family'] then type['font-family'] else ''
      fontSize = if type and type['font-size'] then type['font-size'] else ''
      fontColor = if type and type['color'] then type['color'] else ''

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