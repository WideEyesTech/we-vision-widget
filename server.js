var express = require('express');
var app = null;

app = express();
app.get('/');
var server = app.listen(3000, 'http://' + process.env.SAUCE_USERNAME + ':' + process.env.SAUCE_ACCESS_KEY + '@ondemand.saucelabs.com/wd/hub',
  function () {
    var host = server.address().address;
    var port = server.address().port;
    console.log('Example app listening at http://%s:%s', host, port);
  });
app.use(express.static(__dirname));
