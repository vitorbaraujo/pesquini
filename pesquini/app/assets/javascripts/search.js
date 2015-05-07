 $(document ).ready(function ( ) {
  var element = document.getElementById('enterprises_index').getElementsByClassName("fa_search")[0];
  var search1 = document.getElementById('enterprises_index').getElementsByClassName("search_form_enterprises")[0];

  $(element).on('click', function () {
    $(search1).removeClass("off");
    $(element).parent().addClass('off');
  });


});