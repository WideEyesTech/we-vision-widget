define(['handlebars.runtime'], function(Handlebars) {
  Handlebars = Handlebars["default"];  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
return templates['product_container.hbs'] = template({"1":function(depth0,helpers,partials,data) {
  var stack1, lambda=this.lambda, escapeExpression=this.escapeExpression;
  return "    <section class=\"image-container\">\n      <a href=\""
    + escapeExpression(lambda((depth0 != null ? depth0.ProductUrl : depth0), depth0))
    + "\">\n        <img class=\"productsImage\" src=\""
    + escapeExpression(lambda(((stack1 = (depth0 != null ? depth0.ImgUrls : depth0)) != null ? stack1['0'] : stack1), depth0))
    + "\">\n      </a>\n    </section>\n";
},"3":function(depth0,helpers,partials,data) {
  var lambda=this.lambda, escapeExpression=this.escapeExpression;
  return "        <h4 class=\"product-title bold\">\n          "
    + escapeExpression(lambda((depth0 != null ? depth0.ProductName : depth0), depth0))
    + "\n        </h4>\n";
},"5":function(depth0,helpers,partials,data) {
  var stack1, lambda=this.lambda, escapeExpression=this.escapeExpression;
  return "       <p>"
    + escapeExpression(lambda(((stack1 = (depth0 != null ? depth0.ProductCustomData : depth0)) != null ? stack1.price : stack1), depth0))
    + " &euro;</p>\n";
},"compiler":[6,">= 2.0.0-beta.1"],"main":function(depth0,helpers,partials,data) {
  var stack1, buffer = "<div class=\"card\">\n  <div class=\"inner\">\n";
  stack1 = helpers['if'].call(depth0, (depth0 != null ? depth0.ImgUrls : depth0), {"name":"if","hash":{},"fn":this.program(1, data),"inverse":this.noop,"data":data});
  if (stack1 != null) { buffer += stack1; }
  buffer += "    <article class=\"text-xs-center text-md-left\">\n      <header>\n";
  stack1 = helpers['if'].call(depth0, (depth0 != null ? depth0.ProductName : depth0), {"name":"if","hash":{},"fn":this.program(3, data),"inverse":this.noop,"data":data});
  if (stack1 != null) { buffer += stack1; }
  buffer += "      </header>\n";
  stack1 = helpers['if'].call(depth0, ((stack1 = (depth0 != null ? depth0.ProductCustomData : depth0)) != null ? stack1.price : stack1), {"name":"if","hash":{},"fn":this.program(5, data),"inverse":this.noop,"data":data});
  if (stack1 != null) { buffer += stack1; }
  return buffer + "    </article>\n  </div>\n</div>";
},"useData":true});
});