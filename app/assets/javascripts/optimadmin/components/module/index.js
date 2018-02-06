$(document).ready(function() {
  $('.ui-state-active').toggleClass('ui-state-active ui-tabs-active');
  $('.active').parent().addClass('ui-state-active');
});
$(document).on('click', '.tabs-list.module-index a', function(e) {
  window.location = $(this).data('href');
});
