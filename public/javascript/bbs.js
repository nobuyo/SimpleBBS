// $("#btn-post").prop("disabled", true);

$("input[name='mess']").change(function () {
  if ($(this).val() != "") {
    $("#btn-post").prop("disabled", false);
  }
  else {
    $("#btn-post").prop("disabled", true);
  }
});