$(document).ready(function() {
  $("#forget_pass_form").focusout(function() {
    if ($("#inputValidationEx67").hasClass("valid")) {
      $("#send_link").prop("disabled", false);
      $(".error-msg").removeClass( "visible" ).addClass( "in-visible" );
    }
    else if ($("#inputValidationEx67").hasClass("invalid")) {
        $(".error-msg").removeClass( "in-visible" ).addClass( "visible" );
      }
    else{
        $("#send_link").prop("disabled", true);
    }
    if($("#inputValidationEx67")[0].value==""){
        $(".error-msg").removeClass( "visible" ).addClass( "in-visible" );
    }
  });

  $("#forget_pass_form").submit(function(e) {
    e.preventDefault();
    window.location.replace("/pages/resetConfirm.html");
  });
});
