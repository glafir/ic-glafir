$(function (){
        $('#timetableap_DateOfStartNav').datepicker({
	    changeYear: true,
	    dateFormat: "yy-mm-dd",
	    changeMonth: true,
	    minDate: "-15y",
	    maxDate: "+2y",
	    closeText: "Закрыть",
	    showWeek: true,
	    duration: 300
	});
        $('#timetableap_DateOfEndNav').datepicker({
            changeYear: true,
	    dateFormat: "yy-mm-dd",
            changeMonth: true,
	    minDate: "-15y",
            maxDate: "+2y",
	    closeText: "Закрыть",
	    showWeek: true,
	    defaultDate: +365,
            duration: 300
	});
//  $("#timetableaps th a, #timetableaps .pagination a").on("click", '', function() {
//    $.getScript(this.href);
//    return false;
//  });
//  $("#timetableaps_search input").keyup(function() {
//    $.get($("#timetableaps_search").attr("action"),
//    $("#timetableaps_search").serialize(), null, "script");
//    return false;
//  });
});


//$(document).ready(function () {
//  $("#new_timetableap").validate({
//    focusInvalid: false,
//    focusCleanup: true,
//    rules: {
//      "timetableap[Flight_Number]": {required: true, maxlength: 4, number: true},
//      "timetableap[DateOfStartNav]": {required: true, maxlength: 10},
//      "timetableap[DateOfEndNav]": {required: true, maxlength: 10 }
//    },
//    messages: {
//        "timetableap[Flight_Number]": "Введите номер рейса",
//        "timetableap[DateOfStartNav]": "Введите дату начала навигации",
//        "timetableap[DateOfEndNav]": "Введите дату конца навигации"
//      }
//    });
//  });

