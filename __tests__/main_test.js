var request = require('supertest');
var express = require('express');
var app = express();

app.get('/', function (req, res) {
  res.send('Hello World!');
});

var server = app.listen(3000, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);
});

app.use(express.static(__dirname));

describe('main test', function () {
    it('should return 200', function(done) {
      request(app)
        .get('/')
        .expect(200)
        .end(function(err, res){
          console.log(res);
          if (err) throw err;
          done();
        });
    });

    it('should check iframe is loaded with content', function (done) {
      browser
        .url('/')
        .waitForExist('#we-vision-iframe', 5000)
        .then(function (bool) {
          browser.frame('we-vision-iframe')
            .then(function () {
              browser
              .waitForExist('.card', 5000)
              .isExisting('.card')
                .then(function(bool) {
                  bool.should.be.equal(true);
                })
                .call(done);
            });
        })
    });
  });
