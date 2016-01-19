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
    var rotationInterval
    var rotationDelay = 5000

    function rotateTo($target) {
      var index = $announcementBullets.index($target)

      $announcementBullets.removeClass('active')
      $target.addClass('active')
      $announcements.removeClass('active')
      $announcements.eq(index).addClass('active')
    }

    function startRotation() {
      clearInterval(rotationInterval)
      rotationInterval = setInterval(function () {
        var $nextAnnouncement = $('.announcement-js .bullet.active').next()
        $nextAnnouncement = $nextAnnouncement.length === 0 ? $announcementBullets.eq(0) : $nextAnnouncement
        rotateTo($nextAnnouncement)
      }, rotationDelay)
    }

    $announcementBullets.on('click', function (e) {
      rotateTo($(e.currentTarget))
      startRotation()
    })

    startRotation()
  })()
});
