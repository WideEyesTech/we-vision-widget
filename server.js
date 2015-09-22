var express = require('express');
var app = null;

isPortTaken(3000, function (err, bool) {
  if (bool) {
    return;
  } else {
    app = express();
    app.get('/');
    var server = app.listen(port, function () {
      var host = server.address().address;
      var port = server.address().port;
      console.log('Example app listening at http://%s:%s', host, port);
    });
    app.use(express.static(__dirname));
  }
});

function isPortTaken(port, fn) {
  var net = require('net')
  var tester = net.createServer()
    .once('error', function (err) {
      if (err.code != 'EADDRINUSE') return fn(err)
      fn(null, true)
    })
    .once('listening', function () {
      tester.once('close', function () {
          fn(null, false)
        })
        .close()
    })
    .listen(port)
}
