// $("#btn-post").prop("disabled", true);

$("input[name='mess']").blur(function(){
  if($(this).val() == ""){
    $("#btn-post").prop("disabled", false);
  }
});