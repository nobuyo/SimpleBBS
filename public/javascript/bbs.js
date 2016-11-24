// $("#btn-post").prop("disabled", true);

$("input[name='mess']").change(function () {
  if ($(this).val() != "") {
    $("#btn-post").prop("disabled", false);
  }
  else {
    $("#btn-post").prop("disabled", true);
  }
});


function key_down(get_code){
  if ((
      get_code >= 48 && get_code <= 57
   || get_code >= 96 && get_code <= 105
  ) && ($("input[name='del_key']").val().length < 4) || (get_code == 8) && ($("input[name='del_key']").val().length < 5))
   return true;
  else
   return false;
}
