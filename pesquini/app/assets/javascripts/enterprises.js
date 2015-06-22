 $(document ).ready(function ( ) {

if(document.URL.indexOf("#tf-sanction_by_state") != -1) {
  $("#tf-sanction_by_state").css("background-color","#101010");
  $("#tf-sanction_by_state").css("color","#F7F7F7");
  $("#tf-sanction_by_state").fadeOut(1);
  $("#tf-sanction_by_state").fadeIn(1500);
}

if(document.URL.indexOf("#tf-most_sanctioned_ranking") != -1) {
  $("#tf-most_sanctioned_ranking").css("background-color","#101010");
  $("#tf-most_sanctioned_ranking").css("color","#F7F7F7");
  $("#tf-most_sanctioned_ranking").fadeOut(1);
  $("#tf-most_sanctioned_ranking").fadeIn(1500);
}

if(document.URL.indexOf("#tf-sanction_by_type") != -1) {
  $("#tf-sanction_by_type").css("background-color","#101010");
  $("#tf-sanction_by_type").css("color","#F7F7F7");
  $("#tf-sanction_by_type").fadeOut(100);
  $("#tf-sanction_by_type").fadeIn(1500);
}

if(document.URL.indexOf("#tf-payment_rankings") != -1) {
  $("#tf-payment_rankings").css("background-color","#101010");
  $("#tf-payment_rankings").css("color","#F7F7F7");
  $("#tf-payment_rankings").fadeOut(1);
  $("#tf-payment_rankings").fadeIn(1500);
}

});
