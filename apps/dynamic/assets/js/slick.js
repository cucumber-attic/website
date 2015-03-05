$(document).ready(function () {
  $('body').scrollspy({ target: '#side-nav' });

  // Code carousels
  var ignoreCarouselEvents = false;
  $('.carousel').slick({
    autoplay: false,
    arrows: false,
    adaptiveHeight: true,
    draggable: false,
    swipe: true,
    focusOnSelect: true
  }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
    if(nextSlide == currentSlide) return;
    ignoreCarouselEvents = true;
    $('.carousel').slick('slickGoTo', nextSlide);
    ignoreCarouselEvents = false;

    var language = $(".slide-link[data-slide="+ nextSlide +"]").first().text();
    $('.current-slide').text(language);
  });

  // Carousel control
  $('.slide-link').click(function (e) {
    var slide = parseInt(e.target.dataset.slide);
    if ($('.carousel').slick('slickCurrentSlide') == slide) return;
    $('.carousel').slick('slickGoTo', slide);
  });
});
