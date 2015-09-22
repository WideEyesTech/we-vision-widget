// var app = require('../server.js');
var request = require('supertest');

describe('main test', function () {
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
                .then(function (bool) {
                  bool.should.be.equal(true);
                })
                .call(done);
          });
      });
  });
});
