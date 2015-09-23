describe('main test', function () {
  it('should check iframe is loaded with content', function (done) {
    browser.url('/')
      .getTitle().then(function (title) {
        expect(title).toEqual("WE Widget Test Page");
      })
      .waitForExist('#we-vision-iframe', 5000)
      .frame('we-vision-iframe')
      .waitForExist('.card', 5000)
      .isExisting('.card')
        .then(function (bool) {
          expect(bool).toBe(true);
        })
        .call(done);
  });
});
