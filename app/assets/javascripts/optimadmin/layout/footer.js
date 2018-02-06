function equalHeight() {
  if (Modernizr.mq('only screen and (min-width: 1024px)')) {
    $('[data-equalizer-watch]').matchHeight();
  }
}

$(document).foundation();

var currentdate = new Date();

$(document).ready(function() {
  $('.datetimepicker').datetimepicker({
    format: "d-m-Y H:i",
    defaultTime: currentdate.getHours() + ':' + currentdate.getMinutes(),
    step: 15
  });
});

$(window).load(function() {
  equalHeight();
});

$('.multiple-select').multipleSelect({
  selectAll: false,
  filter: true,
  placeholder: "Please select"
});

// https://wordpress.org/support/topic/disable-background-scrolling-when-colorbox-layer-is-active
if (Modernizr.mq('only screen and (min-width: 1024px)')) {
  $(document).bind('cbox_open', function() {
      $('body').css({ overflow: 'hidden' });
  }).bind('cbox_closed', function() {
      $('body').css({ overflow: '' });
  });
}
