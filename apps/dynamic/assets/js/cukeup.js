//= require modernizr/modernizr
//= require jquery

$(function() {
  $('.schedule-item.openable > *').on('click', function (e) {
    $(e.currentTarget).closest('.schedule-item').toggleClass('open');
  });
});
