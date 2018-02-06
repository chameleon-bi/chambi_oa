$(document).on('change', '#menu_item_link_attributes_menu_resource_type', function() {
  var url = $('.resource-type-select').attr('data-url');
  data = $.get(url + '?klass=' + $(this).val());
});
