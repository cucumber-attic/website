$(document).ready(function() {
  // Initialize scrollspy
  $('body').scrollspy({ target: '#side-nav' });

  // Add responsiveness to images
  $('.js-one-column img').addClass('img-responsive');

  // Fix anchors scroll due to Bootstrap fixed navbar
  var shiftWindow = function () { scrollBy(0, -75) };
  window.addEventListener("hashchange", shiftWindow);
  window.addEventListener("load", function () { if (window.location.hash) { shiftWindow() } });
});
