describe('main test', function () {
  it('should check iframe is loaded with content', function (done) {
    browser
      .url('http://localhost:3000')
      .waitForExist('#we-vision-iframe', 10000)
      .then(function (bool) {
        browser.frame('we-vision-iframe')
          .then(function () {
            browser
              .waitForExist('.card', 10000)
              .isExisting('.card')
                .then(function (bool) {
                  expect(bool).toBe(true);
                })
                .call(done);
          });
      });
  });
});
