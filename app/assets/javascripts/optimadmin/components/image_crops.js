/**
 * Get the value of a querystring
 * @param  {String} field The field to get the value of
 * @param  {String} url   The URL to get the value from (optional)
 * @return {String}       The field value
 */
// http://gomakethings.com/how-to-get-the-value-of-a-querystring-with-native-javascript/
var getQueryString = function ( field, url ) {
    var href = url ? url : window.location.href;
    var reg = new RegExp( '[?&]' + field + '=([^&#]*)', 'i' );
    var string = reg.exec(href);
    return string ? string[1] : null;
};

$(document).on('click', '.image-key-navigation', function() {
  var key = $(this).data('key');

  $('.image-crop-area form').addClass('hide');

  $("#form_" + key).removeAttr('style').removeClass('hide invisible');

  $(".imgareaselect-outer").toggle(false);
  $(".imgareaselect-selection").parent().toggle(false);

  $(".current-crop").removeClass("current-crop");
  $(".nav_" + key).addClass("current-crop");

  if(inIframe() !== true) {
    equalHeight();
  }

  $('.image-crops-hint').remove();
});

// This is a bit hacky but allows positions to be calculated for the crops
$(window).load(function() {
  $('.invisible').css({'position': 'absolute', 'top': -1000});
});

$(document).on('click', '.action-button', function() {
  if(inIframe() === true) {
    parent.jQuery.colorbox.close();
    return false;
  }
});
