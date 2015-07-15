// Generated by CoffeeScript 1.9.1
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

define(function(require) {
  var $, Backbone, ProductContainer, _;
  Backbone = require('backbone');
  $ = require('jquery');
  _ = require('underscore');
  return ProductContainer = (function(superClass) {
    extend(ProductContainer, superClass);

    function ProductContainer() {
      return ProductContainer.__super__.constructor.apply(this, arguments);
    }

    ProductContainer.prototype.template = require('templates/product_container');

    ProductContainer.prototype.events = {
      'click a': '_onClick'
    };

    ProductContainer.prototype.initialize = function(options) {
      this.config = options.widget_configuration;
      this.product_id = options.product_id;
      return this;
    };

    ProductContainer.prototype.render = function() {
      if (this.template) {
        this.setElement(this.template(this._getTemplateData()));
        this.$el.addClass('');
      }
      ProductContainer.__super__.render.apply(this, arguments);
      return this;
    };

    ProductContainer.prototype._onClick = function() {
      var headers;
      headers = {};
      headers.apikey = this.config.apikey;
      return $.ajax({
        method: "POST",
        url: "http://api.wide-eyes.it/widget/clicks",
        data: '{}',
        dataType: 'json',
        contentType: 'application/json; charset=UTF-8',
        headers: headers,
        crossDomain: true,
        processData: false,
        error: (function(_this) {
          return function(error) {
            return console.log(error);
          };
        })(this),
        success: (function(_this) {
          return function(response) {};
        })(this)
      });
    };

    ProductContainer.prototype._getTemplateData = function() {
      return this.model;
    };

    return ProductContainer;

  })(Backbone.View);
});
