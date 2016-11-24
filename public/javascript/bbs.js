// $("#btn-post").prop("disabled", true);

$("input[name='mess']").on('blur', function () {
  if ($(this).val() != "") {
    $("#btn-post").prop("disabled", false);
  }
});