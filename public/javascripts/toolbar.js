function removeToolbar()
{
   var ELiframe = document.getElementById('TMP__mainframe');
   if( ELiframe != null )
   {
var url = ELiframe.src;
      document.location.assign(url);
   } else {       
$('TMP__toolbar').hide('fast');
   }
}

function resizeIframe() 
{
   $('#iframewrapper').css('height',$(document).height()+1000);
 };
 $(document).ready(function(){
resizeIframe();
});

// Mmmmm jQuery
$(document).ready(function() {
  $('input[name=original_url]').focus(function() {
    $(this).select();
  });
});
