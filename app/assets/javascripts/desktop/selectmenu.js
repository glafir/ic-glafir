  $(function() {
    $( "select" ).each(function(){
      $(this).selectmenu({
      position: {my:"left+10 top",
                 at:"left top+30"}})
      .selectmenu( "menuWidget" )
        .addClass( "select_overflow" );
    });
  });
