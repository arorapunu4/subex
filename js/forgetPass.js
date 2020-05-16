$(document).ready(function() {
  $("#forget_pass_form").focusout(function() {
    if ($("#inputValidationEx67").hasClass("valid")) {
      $("#send_link").prop("disabled", false);
    }
    else{
        $("#send_link").prop("disabled", true);
    }
  });

  $("#forget_pass_form").submit(function(e) {
    e.preventDefault();
    window.location.replace("/resetConfirm.html");
  });
});
