function toggleForms(image_id, image_name, url) {
  $("#optimadmin_images_for_" + image_name + " .highlight").removeClass("highlight").addClass("lowlight");
  $("#optimadmin_images_for_" + image_name + " " + image_id).removeClass("lowlight").addClass("highlight");

  $("#<%= f.object.class.name.underscore %>_remote_" + image_name + "_url").val(url);
}

function setImage(imageFieldId, imageName) {
  selectedImageUrl = $('#' + imageName + ' .slick-center:first').data("main-image-url");
  selectedThumbImageUrl = $('#' + imageName + ' .slick-center:first').data("thumb-image-url");
  $('#' + imageFieldId).val(selectedImageUrl);

  if($('#preview_' + imageName).length) {
    $('#preview_' + imageName).attr('src', selectedThumbImageUrl);
  } else {
    $('<br /><img id="preview_' + imageName + '" src="' + selectedThumbImageUrl + '" />').insertAfter('#container_' + imageName + ' .first-label');
  }

  $('#container_' + imageName + ' .toggle-class').click();
}

function setImageFromList(imageFieldId, imageName, selectedImageUrl, selectedThumbImageUrl) {
  $('#' + imageFieldId).val(selectedImageUrl);

  if($('#preview_' + imageName).length) {
    $('#preview_' + imageName).attr('src', selectedThumbImageUrl);
  } else {
    $('<br /><img id="preview_' + imageName + '" src="' + selectedThumbImageUrl + '" />').insertAfter('#container_' + imageName + ' .first-label');
  }

  $('#container_' + imageName + ' .toggle-class').click();
  window.location.href = '#container_' + imageName;
}

$(document).on('click', '.set-image', function() {
  setImage($(this).data('image-field-id'), $(this).data('image-name'));
});

$(document).on('click', '.image-select-list', function() {
  setImageFromList($(this).data('image-field-id'), $(this).data('image-name'), $(this).data('main-image-url'), $(this).data('thumb-image-url'));
});

$(document).on('click', '.from-existing', function() {
  $('.slick-image-selector').slick('setPosition');
});

$(document).on('click', '.slick-image-selector .slick-slide', function (e) {
  e.stopPropagation();
  var index = $(this).data("slick-index");
  if ($('.slick-slider').slick('slickCurrentSlide') !== index) {
    $('.slick-slider').slick('slickGoTo', index);
  }
});
