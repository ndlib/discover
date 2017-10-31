$(document).ready(function(){

  $('.cbox').live('click', function(event){
    event.preventDefault();
    var ur = $(this).attr('href');
    var ht = '<div id="itoutter" style="width: 300px; height: 200px;"><img style="display: block; margin: auto; padding-top: 70px;" src="../images/local/loading_alt.gif" /></div>';
    var xh = ajHandle();
    $.colorbox({html:ht, onClosed:function(){ xh.abort(); }});
    performAj(xh, ur, "GET", "", "colorbox");

  });

  $('.mbox').live('click', function(event){
    event.preventDefault();
    var dat = $(this).attr('href').split('jsp?xml=')[1];
    var ht = '<div id="mps" style="width: 300px; height: 300px;"><img style="display: block; margin: auto; padding-top: 70px;" src="../images/local/loading_alt.gif" /></div>';
    var xml = $.parseXML(decodeURIComponent(dat));
    console.log(xml.getElementsByTagName('collection'))
    var col = xml.getElementsByTagName('collection')[0].getAttribute('code');
    var sublib = xml.getElementsByTagName('sublibrary')[0].getAttribute('code');
    var cn = encodeURIComponent(xml.getElementsByTagName('call_number')[0].innerHTML);
    var xh = ajHandle();
    $.colorbox({html:ht, onClosed:function(){ xh.abort(); } });
    performAjContentful(xh, col, sublib, cn);
  });

});

function ajHandle(){
  var xmlhttp;
  if (window.XMLHttpRequest){
    // code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp=new XMLHttpRequest();
  }else{
    // code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }

  return xmlhttp;

}

function performAjContentful(xmlhttp, col, sublib, cn) {
  xmlhttp.onreadystatechange=function(){
    if (xmlhttp.readyState==4 && xmlhttp.status==200){
      var json = JSON.parse(xmlhttp.responseText);
      var imageUrl = json.fields.image.fields.file.url;
      var size = Math.floor(Math.min($(window).height(), $(window).width()) * 0.85);
      $.colorbox({html: '<div><img src="' + imageUrl +'" width="' + size + 'px" height="' + size + 'px"/></div>', scrolling: false});
    }
  }
  xmlhttp.open('GET', 'https://bj5rh8poa7.execute-api.us-east-1.amazonaws.com/dev/map?collection=' + col + '&sublibrary=' + sublib + '&call_number=' + cn);
  xmlhttp.send();
}


function performAj(xmlhttp, url, m, dat, type){

  xmlhttp.onreadystatechange=function(){
    if (xmlhttp.readyState==4 && xmlhttp.status==200){
      var dt = xmlhttp.responseText;
      if(type == "colorbox"){
        $.colorbox({html:dt, scrolling:false});
      }
    }else if(xmlhttp.readyState==4 && xmlhttp.status != 200){
      if(type == "colorbox"){
             // setTimeout($.colorbox({html:xmlhttp.responseText}), 1000);
      }
    }
  };

  if(m == 'POST'){
    xmlhttp.open("POST",url,true);
    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xmlhttp.send(dat);
  }else{
    xmlhttp.open("GET",url + "&t=" + Math.random(),true);
    xmlhttp.send();
  }
}
