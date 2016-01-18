$(document).ready(function() {
  // Initialize scrollspy
  $('body').scrollspy({ target: '#side-nav', offset: 85 });

  // Add responsiveness to images
  $('.js-one-column img').addClass('img-responsive');

  // Fix anchors scroll due to Bootstrap fixed navbar
  var shiftWindow = function () { scrollBy(0, -75) };
  window.addEventListener("hashchange", shiftWindow);
  window.addEventListener("load", function () { if (window.location.hash) { shiftWindow() } });

  // Announcements
  (function () {
    var $announcementBullets = $('.announcement-js .bullet')
    var $announcements = $('.announcement-js .announcement-text')

    $announcementBullets.on('click', function (e) {
      var $target = $(e.currentTarget)
      var targetIndex = $announcementBullets.index($target)

      $announcementBullets.removeClass('active')
      $target.addClass('active')

      $announcements.removeClass('active')
      $announcements.eq(targetIndex).addClass('active')
    })
  })()
});
