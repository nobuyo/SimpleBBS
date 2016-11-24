// $("#btn-post").prop("disabled", true);

$("input[name='mess']").focusout(function () {
  if ($(this).val() != "") {
    $("#btn-post").prop("disabled", false);
  }
});