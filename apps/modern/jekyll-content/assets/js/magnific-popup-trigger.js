$(document).ready(function() {
  $('.image-popup').magnificPopup({ 
    type: 'image',
    mainClass: 'mfp-with-zoom',
    closeOnContentClick: true,
    showCloseBtn: false,
  });

  $('.inline-popup').magnificPopup({ 
    type: 'inline',
    mainClass: 'mfp-with-zoom',
    closeOnContentClick: true,
    showCloseBtn: false
  });
});
