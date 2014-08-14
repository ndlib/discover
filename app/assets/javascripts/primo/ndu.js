
$(document).ready(function(){

  var fd = EXLTA_isFullDisplay();

  $('.EXLResultTabs').each(
    function(){
      if(!$(this).children('.EXLLocationsTab').attr('class') && !$(this).children('.EXLViewOnlineTab').attr('class')){
        $(this).parent().parent().parent().children('.EXLSummaryContainer').children('.EXLSummaryFields').children('.EXLResultAvailability').html('');

      }
    }
  );

  $('.EXLReviewsTab').each(
    function(){
      var rt = $(this);
      var dn = EXLTA_recordId($(this));
      if(dn){
        var ddud = 'pnxId=' + dn;
        var ddui = '/primo_library/libweb/tiles/local/docdel.jsp';
        $.ajax({
          type: "get",
          url: ddui,
          dataType: "html",
          data: ddud,
          success: function(data) {
          var dre = /http/;
          if(data.match(dre)){
            rt.after('<li id="docDelUrl" class="EXLResultTab">' + data + '</li>');
          }
          }
        });
        var rud = 'pnxId=' + dn + '&institution=NDU';
        var rui = '/primo_library/libweb/tiles/local/request.jsp';
        if (/aleph/.test(dn)) {
          rt.siblings('.ndl-request-tab').hide();
          $.ajax({
            type: "get",
            url: rui,
            dataType: "html",
            data: rud,
            success: function(data) {
          var dre = /<div id="requestable">yes<\/div>/;
          if(data.match(dre)){
                rt.siblings('.ndl-request-tab').show();
              } else {
                rt.siblings('.ndl-request-tab').hide();
              }

            }
          });
        } else {
          rt.siblings('.ndl-request-tab').show();
          }



      }


    });

    $('.ndl-details-tab').each(
        function(){
            var dt = $(this);
            var dn = EXLTA_recordId($(this));
            if(dn){
                var ddud = 'pnxId=' + dn;
                var ddui = '/primo_library/libweb/tiles/local/docdel.jsp';
                $.ajax({type: "get", url: ddui, dataType: "html", data: ddud,  success: function(data){
                    var dre = /http/;
                    if(data.match(dre)){
                        dt.before('<li id="docDelUrl" class="EXLResultTab">' + data + '</li>');
                    }
                }});

            }
    });


});


function EXLTA_recordId(element){
  return $(element).parents('.EXLResult').find('.EXLResultRecordId').attr('id');
}
