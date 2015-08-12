// Generated by CoffeeScript 1.9.1
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

define(function(require) {
  var Backbone, ProductsContainer, WidgetContainer, _, jsonTemplate;
  Backbone = require('backbone');
  jsonTemplate = require('templates/json');
  ProductsContainer = require('ProductsContainer');
  _ = require('underscore');
  return WidgetContainer = (function(superClass) {
    extend(WidgetContainer, superClass);

    function WidgetContainer() {
      return WidgetContainer.__super__.constructor.apply(this, arguments);
    }

    WidgetContainer.prototype.template = require('templates/widget_container');

    WidgetContainer.prototype.initialize = function(options) {
      _.bindAll(this);
      this.widget_configuration = options.conf;
      this.product_id = options.product_id;
      return this;
    };

    WidgetContainer.prototype.render = function() {
      var j, len, products_container, ref, row;
      this._extractModelData();
      if (this.template) {
        this.setElement(this.template(this._getTemplateData()));
        this.$el.addClass('');
      }
      ref = this.rows;
      for (j = 0, len = ref.length; j < len; j++) {
        row = ref[j];
        products_container = new ProductsContainer({
          model: row,
          product_id: this.product_id,
          widget_configuration: this.widget_configuration
        });
        this.$el.append(products_container.render().el);
      }
      WidgetContainer.__super__.render.apply(this, arguments);
      return this;
    };

    WidgetContainer.prototype.show = function(callback) {
      if (callback == null) {
        callback = function() {};
      }
      return callback();
    };

    WidgetContainer.prototype.hide = function(callback) {
      if (callback == null) {
        callback = function() {};
      }
      return callback();
    };

    WidgetContainer.prototype._extractModelData = function() {
      var itemCount, parsed_results, results;
      results = products;
      parsed_results = this._parseVisionResults(results);
      itemCount = config.layout.minColumnCount || 4;
      parsed_results = this._chunkData(parsed_results, itemCount);
      return this.rows = parsed_results;
    };

    WidgetContainer.prototype._chunkData = function(arr, size) {
      var i, item, j, len, newArr, ref;
      newArr = [];
      ref = size;
      for ((ref > 0 ? (i = j = 0, len = arr.length) : i = j = arr.length - 1); ref > 0 ? j < len : j >= 0; i = j += ref) {
        item = arr[i];
        newArr.push(arr.slice(i, i + size));
      }
      return newArr;
    };

    WidgetContainer.prototype._parseVisionResults = function(results) {
      var i, list;
      list = [];
      i = 0;
      while (i < results.result_both.length) {
        if (i >= this.widget_configuration.layout.itemCount) {
          break;
        }
        list = list.concat(results.result_both[i]);
        i++;
      }
      if (results.result_both.length === 0) {
        i = 0;
        while (i < results.result_shape.length) {
          if (i >= this.widget_configuration.layout.itemCount) {
            break;
          }
          list = list.concat(results.result_shape[i]);
          i++;
        }
      }
      if (results.result_both.length === 0 && results.result_shape.length === 0) {
        i = 0;
        while (i < results.result_color.length) {
          if (i >= this.widget_configuration.layout.itemCount) {
            break;
          }
          list = list.concat(results.result_color[i]);
          i++;
        }
      }
      list = this._filterTileContent(list);
      return list;
    };

    WidgetContainer.prototype._filterTileContent = function(list) {
      var i;
      i = 0;
      while (i < list.length) {
        if (!config.tile.hasTitle) {
          delete list[i].ProductName;
        }
        if (typeof list[i].ProductCustomData === "string") {
          if (list[i].ProductCustomData === '') {
            list[i].ProductCustomData = '';
          } else {
            list[i].ProductCustomData = JSON.parse(list[i].ProductCustomData);
            if (!config.tile.hasDescription) {
              delete list[i].ProductCustomData.description;
            }
            if (!config.tile.hasPrice) {
              delete list[i].ProductCustomData.price;
            } else {
              list[i].ProductCustomData.price = list[i].ProductCustomData.price.toFixed(2);
            }
          }
        }
        i++;
      }
      return list;
    };

    WidgetContainer.prototype._filterProductFromVisionResults = function(results, productId) {
      var res;
      res = {};
      res.result_both = results.result_both.filter(function(val, indx, arr_obj) {
        if (val.ProductId === productId) {
          return false;
        } else {
          return true;
        }
      });
      res.result_shape = results.result_shape.filter(function(val, indx, arr_obj) {
        if (val.ProductId === productId) {
          return false;
        } else {
          return true;
        }
      });
      res.result_color = results.result_color.filter(function(val, indx, arr_obj) {
        if (val.ProductId === productId) {
          return false;
        } else {
          return true;
        }
      });
      return res;
    };

    WidgetContainer.prototype._getTemplateData = function() {
      return {
        products: this.rows
      };
    };

    return WidgetContainer;

  })(Backbone.View);
});
