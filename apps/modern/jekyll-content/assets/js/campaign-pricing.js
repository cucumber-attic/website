$(document).ready(function() {
  var plans = {
    solo: {
      users: 1,
      pricePerUserPerMonth: 25,
      planName: 'a-pay-solo-2014-06',
      planDescription: 'Solo plan'
    },
    small: {
      users: 5,
      pricePerUserPerMonth: 20,
      planName: 'a-pay-small-2014-06',
      planDescription: 'Small plan'
    },
    medium: {
      users: 10,
      pricePerUserPerMonth: 20,
      planName: 'a-pay-medium-2014-06',
      planDescription: 'Medium plan'
    },
    large: {
      users: 50,
      pricePerUserPerMonth: 16,
      planName: 'a-pay-large-2014-06',
      planDescription: 'Large plan'
    }
  };
  $.each(['solo', 'small', 'medium', 'large'], function(n, plan) {
    var pricePerPlanPerMonth = plans[plan].pricePerUserPerMonth * plans[plan].users;

    $('#js-'+plan+'-description').text(plans[plan].planDescription);
    $('#js-'+plan+'-collaborators').text(plans[plan].users);
    $('#js-'+plan+'-price-per-user-per-month').text(plans[plan].pricePerUserPerMonth);
    $('#js-'+plan+'-price-per-plan-per-month').text(pricePerPlanPerMonth);

    $('#js-buy-'+plan).buyButton(pricePerPlanPerMonth, plans[plan].planName, plans[plan].planDescription);
  });
});
