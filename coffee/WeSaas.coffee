define (require) ->

  _ = require 'underscore'
  Backbone = require 'backbone'

  class WeSaas extends Backbone.Model

    urlRoot: ->
      'http://api.wide-eyes.it/v1/SearchById'

    initialize: ->
      @listenTo @, 'sync', @_onSync

    save: ->
      @set @_submodelsToJSON()
      super({},{ headers: {'Authorization' :'api_key ' + window.bearer_token} })

    hasUnsavedChanges: ->
      !_.isEqual @toJSON(), @_lastSavedData

    _onSync: ->
      @_lastSavedData = @toJSON()
