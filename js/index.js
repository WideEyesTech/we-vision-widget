// Generated by CoffeeScript 1.9.1
var config, data, html, iframe, product_id, req, widget;

product_id = window.wide_eyes_product_id;

config = window.wide_eyes_config;

config = JSON.stringify(config);

data = {
  ProductId: product_id,
  MinNumResults: 30
};

req = new XMLHttpRequest();

req.addEventListener('readystatechange', function() {
  if (req.readyState === 4 && req.status === 200) {
    return req.responseText;
  }
});

req.open('POST', 'http://api.wide-eyes.it/v1/SearchById', false);

req.setRequestHeader('Authorization', 'Bearer 5bb5bb125672a4e2e97561cca754d348f54d4245');

req.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');

req.send(JSON.stringify(data));

iframe = document.createElement('iframe');

iframe.setAttribute('style', 'width: 100%; border: none; min-height: 300px; box-shadow: none;');

widget = document.getElementById('widget');

widget.appendChild(iframe);

html = '<!doctype html> <html> <head> <script src="js/vendor/requirejs/require.js"></script> <script> var products=' + req.responseText + '; var config=' + config + '; </script> </head> <body> <section id="widget"> </section> <script src="js/main.js"></script> </body> </html>';

iframe.contentWindow.document.open();

iframe.contentWindow.document.write(html);

iframe.contentWindow.document.close();