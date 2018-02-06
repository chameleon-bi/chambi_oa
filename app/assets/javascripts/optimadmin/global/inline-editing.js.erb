var optimadminiFrameCookie = 'optimadmin_iframe';
var adminInlineNavigationUrl = '/admin/inline-editing/navigation';

function menubarLoaded() {
  var $moduleList = $('.content-categories').html();
  $('.optimadmin-module-list').html($moduleList);
  $('.content-category-type').remove();
  $('.content-category-list li a').addClass('optimadmin-editable');
  $('body').css('margin-top', $('.optimadmin-menu-bar').outerHeight());
}

$(document).ready(function() {
  document.cookie = optimadminiFrameCookie + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT; path=/';
  $('body').prepend('<div class="optimadmin-inline-editing"><iframe src="" class="optimadmin-inline-frame"></iframe></div>');
  $('body').prepend('<div class="optimadmin-menu-bar"></div>');
  $('body').prepend('<div class="optimadmin-close-inline-editing">Close window</div>');
  /*
  var optimadminModel = $('.optimadmin-main-editable').data('model');
  var optimadminId = $('.optimadmin-main-editable').data('id');
  adminInlineNavigationUrl = adminInlineNavigationUrl + '?model=' + optimadminModel + '&' + 'id=' + optimadminId;
  $('.optimadmin-menu-bar').load(adminInlineNavigationUrl, menubarLoaded);
  */
});

$(document).on('click', '.optimadmin-editable', function() {
  document.cookie = optimadminiFrameCookie + "=1; path=/";

  $('.optimadmin-inline-frame').attr('src', $(this).attr('href'));
  $('.optimadmin-inline-editing, .optimadmin-close-inline-editing').show();
  $('body').css('overflow-y', 'hidden');
  return false;
});

$(document).on('click', '.optimadmin-remote-logout', function() {
  document.cookie = optimadminiFrameCookie + "=1; path=/";
  $('.optimadmin-inline-frame').attr('src', $(this).attr('href'));
  $('body').css('overflow-y', 'hidden');
  return false;
});

$(document).on('click', '.optimadmin-inline-editing, .optimadmin-close-inline-editing', function(e) {
  if (e.target !== this) {
    return;
  }

  document.cookie = optimadminiFrameCookie + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT; path=/';
  $('.optimadmin-inline-editing, .optimadmin-close-inline-editing').hide();
  $('body').css('overflow-y', 'auto');
  $('.optimadmin-inline-frame').attr('src', '');
});
