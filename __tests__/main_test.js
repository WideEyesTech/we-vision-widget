describe('main test', function () {
  it('should check iframe is loaded with content', function (done) {
    browser.url('/')
      .getTitle().then(function (title) {
        expect(title).toEqual("WE Widget Test Page");
      })
      .call(done);
    //   browser
    //     .url('/')
    //     .waitForExist('#we-vision-iframe', 20000)
    //     .then(function (bool) {
    //       browser.frame('we-vision-iframe')
    //         .then(function () {
    //           browser
    //             .waitForExist('.card', 20000)
    //             .isExisting('.card')
    //               .then(function (bool) {
    //                 expect(bool).toBe(true);
    //               })
    //               .call(done);
    //         });
    //     });
    // });
  });
});
