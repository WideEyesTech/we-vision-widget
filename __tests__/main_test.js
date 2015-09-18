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
                expect(true).toBeTruthy();
              })
              .call(done);
          });
      })
  });
});
