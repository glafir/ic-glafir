$(function() {
//  $("#airports th a, #airports .pagination a").on("click", '', //function() {
//    $.getScript(this.href);
//    return false;
//  });
  $("#airports_search input").keyup(function() {
    $.get($("#airports_search").attr("action"),
    $("#airports_search").serialize(), null, "script");
    return false;
  });
//  $("#timetableaps_search input").keyup(function() {
//    $.get($("#timetableaps_search").attr("action"),
//    $("#timetableaps_search").serialize(), null, "script");
//    return false;
//  });
});
$(function (){
        $('#article_published_on').datepicker();
});
$(document).ready(function () {
  $("#ap_dist").validate({
    focusInvalid: false,
    focusCleanup: true,
    rules: {
      "start": {required: true, minlength: 3},
      "end": {required: true, minlength: 3},
    },
    messages: {
        "start": "Введите аэропорт отправления",
        "end": "Введите аэропорт назначения",
      }
    });
  });

