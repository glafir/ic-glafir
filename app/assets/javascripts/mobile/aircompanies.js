$(function() {
  $("#aircompanies th a, #aircompanies .pagination a").on("click", '', function() {
    $.getScript(this.href);
    return false;
  });
  $("#aircompanies_search input").keyup(function() {
    $.get($("#aircompanies_search").attr("action"),
    $("#aircompanies_search").serialize(), null, "script");
    return false;
  });
});

