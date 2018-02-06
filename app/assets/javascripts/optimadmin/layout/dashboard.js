var stickyNav, stickyNavHeight;

$(document).ready(function() {
  var stickyNavTop = $('.inline-navigation').offset().top;

  stickyNav = function() {
    var scrollTop = $(window).scrollTop();

    if (scrollTop > stickyNavTop) {
      $('.inline-navigation').addClass('sticky');
      stickyNavHeight = parseInt($('.inline-navigation').height()) + 20;
    } else {
      $('.inline-navigation').removeClass('sticky');
      // this is a bit hacky but just about works. It's needed because the nav is part of the header when there is no scroll
      stickyNavHeight = parseInt($('.inline-navigation').height()) + parseInt($('.inline-navigation').height()) + 20;
    }
  };

  stickyNav();
});

$(window).scroll(function() {
  stickyNav();
});

$(document).on('click', '.inline-navigation a[href*="#"]:not([href="#"])', function() {
  var target = $(this.hash);
  if (target.length) {
    $('html, body').stop(true, true).animate({
      scrollTop: target.offset().top - stickyNavHeight
    }, 1000);
    return false;
  }
});
