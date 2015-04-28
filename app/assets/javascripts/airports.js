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
