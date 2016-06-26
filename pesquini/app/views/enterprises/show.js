/*
  File: show.js
  Purpose: File that renders javascript in show view
  License : LGPL. No copyright.
*/

var sanctions_button = document.getElementById("sanction-info-btn");

if ($(sanctions_button).hasClass("active"))
{
  $(".sanction-info").html("<%= escape_javascript(render("sanctions")) %>");
}
else
{
  $(".payment-info").html("<%= escape_javascript(render("payments")) %>");
}