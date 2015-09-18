define(['handlebars.runtime'], function(Handlebars) {
  Handlebars = Handlebars["default"];  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
return templates['product_container.hbs'] = template({"1":function(depth0,helpers,partials,data) {
  var stack1, lambda=this.lambda, escapeExpression=this.escapeExpression;
  return "        <img class=\"productsImage\" src=\""
    + escapeExpression(lambda(((stack1 = (depth0 != null ? depth0.ProductCustomData : depth0)) != null ? stack1.thumb_image : stack1), depth0))
    + "\" data-large-img-url=\""
    + escapeExpression(lambda((depth0 != null ? depth0.ImgUrls : depth0), depth0))
    + "\">\n";
},"3":function(depth0,helpers,partials,data) {
  var lambda=this.lambda, escapeExpression=this.escapeExpression;
  return "        <img class=\"productsImage\" src=\""
    + escapeExpression(lambda((depth0 != null ? depth0.ImgUrls : depth0), depth0))
    + "\" data-large-img-url=\""
    + escapeExpression(lambda((depth0 != null ? depth0.ImgUrls : depth0), depth0))
    + "\">\n";
},"5":function(depth0,helpers,partials,data) {
  var lambda=this.lambda, escapeExpression=this.escapeExpression;
  return "        <h1 class=\"product-title\">\n            <a href=\""
    + escapeExpression(lambda((depth0 != null ? depth0.ProductUrl : depth0), depth0))
    + "\">"
    + escapeExpression(lambda((depth0 != null ? depth0.ProductName : depth0), depth0))
    + "</a>\n        </h1>\n";
},"7":function(depth0,helpers,partials,data) {
  var stack1, lambda=this.lambda, escapeExpression=this.escapeExpression;
  return "         <h3>"
    + escapeExpression(lambda(((stack1 = (depth0 != null ? depth0.ProductCustomData : depth0)) != null ? stack1.price : stack1), depth0))
    + " &euro;</h3>\n";
},"compiler":[6,">= 2.0.0-beta.1"],"main":function(depth0,helpers,partials,data) {
  var stack1, lambda=this.lambda, escapeExpression=this.escapeExpression, buffer = "<div class=\"card\">\n  <div class=\"inner\">\n    <section class=\"image-container\">\n      <a href=\""
    + escapeExpression(lambda((depth0 != null ? depth0.ProductUrl : depth0), depth0))
    + "\" class=\"magnifier-thumb-wrapper\">\n";
  stack1 = helpers['if'].call(depth0, ((stack1 = (depth0 != null ? depth0.ProductCustomData : depth0)) != null ? stack1.thumb_image : stack1), {"name":"if","hash":{},"fn":this.program(1, data),"inverse":this.program(3, data),"data":data});
  if (stack1 != null) { buffer += stack1; }
  buffer += "      </a>\n    </section>\n    <article class=\"text-xs-center more-info\">\n      <header>\n";
  stack1 = helpers['if'].call(depth0, (depth0 != null ? depth0.ProductName : depth0), {"name":"if","hash":{},"fn":this.program(5, data),"inverse":this.noop,"data":data});
  if (stack1 != null) { buffer += stack1; }
  stack1 = helpers['if'].call(depth0, ((stack1 = (depth0 != null ? depth0.ProductCustomData : depth0)) != null ? stack1.price : stack1), {"name":"if","hash":{},"fn":this.program(7, data),"inverse":this.noop,"data":data});
  if (stack1 != null) { buffer += stack1; }
  return buffer + "      </header>\n    </article>\n  </div>\n</div>\n";
},"useData":true});
});