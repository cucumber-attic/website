$.fn.buyButton = function(pricePerUserPerMonthInDollars, planName, planDescription) {
  var button = this;

  button.click(function(e) {
    var ladda = Ladda.create(button[0]);
    var label = button.find('.ladda-label');

    var stripeCheckout = StripeCheckout.configure({
      key: stripeConfig.publishableKey,
      image: '/images/cucumber-pro-red-circlable-128x128.png',
      billingAddress: true,

      token: function(token, args) {
        label.text('Creating Account');
        ladda.start();
        button.attr('disabled','disabled');
        var url = stripeConfig.chargeUrl;
        if($.cookie('utm_campaign')) {
          url += "?utm_campaign=" + $.cookie('utm_campaign');
        }
        $.ajax({
          type: "POST",
          url: url,
          data: {
            token: token,
            args: args,
            plan: planName
          },
          success: success,
          dataType: 'json'
        }).fail(fail);

        function success(data) {
          label.text('Thank you. Please check your email.');
          ladda.stop();
          button.attr('disabled','disabled');
        }

        function fail() {
          label.text('Buy now');
          ladda.stop();
          button.removeAttr('disabled');
          alert('Something went wrong. Your card was not charged.');
        }
      }
    });

    // Open Checkout with further options
    stripeCheckout.open({
      name: 'Cucumber Ltd',
      description: planDescription,
      amount: pricePerUserPerMonthInDollars * 100 // Stripe wants cents
    });
    e.preventDefault();

  });
};
