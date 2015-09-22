var express = require('express');
var app = express();

app.get("/", function() {
  describe('main test', function () {
    it('checks that the iframe is correctly loading', function (done) {
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
                  server.close();
                })
                .call(done);
            });
        })
    });
  });
});

var server = app.listen("3000");
app.use(express.static(__dirname));
