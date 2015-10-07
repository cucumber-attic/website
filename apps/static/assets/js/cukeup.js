//= require modernizr/modernizr
//= require jquery

$(function() {
  $('.schedule-item.openable > .talk, .schedule-item > * > .workshop').on('click', function (e) {
    var $currentTarget = $(e.currentTarget);
    var $container = $currentTarget.closest('.schedule-item');

    $currentTarget.find('.synopsis').toggleClass('open');

    if ($container.find('.synopsis.open').length > 0)
      $container.addClass('open');
    else {
      $container.removeClass('open');
    }
  });
});
