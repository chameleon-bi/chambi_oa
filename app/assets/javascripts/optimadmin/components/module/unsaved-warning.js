// http://stackoverflow.com/questions/7317273/warn-user-before-leaving-web-page-with-unsaved-changes
var isDirty = false, formSubmitting = false;

window.onload = function() {
  window.addEventListener("beforeunload", function (e) {
    var confirmationMessage = "You have unsaved changes.\n";
    confirmationMessage += 'If you leave before saving, your changes will be lost.';

    if (formSubmitting || !isDirty) {
      return undefined;
    }

    (e || window.event).returnValue = confirmationMessage; //Gecko + IE
    return confirmationMessage; //Gecko + Webkit, Safari, Chrome etc.
  });
};

$(document).on('change', 'form :input', function() {
  isDirty = true;
});

$(document).on('submit', 'form', function() {
  formSubmitting = true;
});
