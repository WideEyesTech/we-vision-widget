var request = require('supertest');
var express = require('express');
var app = express();

app.get('/', function(req, res) {
  res.sendStatus(201);
});
app.listen('3000');
app.use(express.static(__dirname));

describe('main test', function () {
    it('test de prueba', function(done) {
      request(app)
        .get('/')
        .expect(200)
        .end(function(err, res){
          if (err) throw err;
          done();
        });
    });

    // it('checks that the iframe is correctly loading', function (done) {
    //   browser
    //     .url('/')
    //     .waitForExist('#we-vision-iframe', 5000)
    //     .then(function (bool) {
    //       browser.frame('we-vision-iframe')
    //         .then(function () {
    //           browser
    //           .waitForExist('.card', 5000)
    //           .isExisting('.card')
    //             .then(function(bool) {
    //               bool.should.be.equal(true);
    //             })
    //             .call(done);
    //         });
    //     })
    // });
  });
