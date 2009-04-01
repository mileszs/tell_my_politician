//lets store all the information that we will need to send.
var CurrentUrl = escape(document.location.href);
var CurrentTitle = escape(document.title);
var CurrentVersion = '1';
//var Server = "http://localhost:3000"; //development
var Server = "http://tellmypolitician.com"; //production

//set some constants just so I don't have to change them in 5 places
var bookmarkletWidth = '645px';
var bookmarkletHeight = '399px';

//we need a place on this page to put everything.
var ELcontainer = document.createElement('div');
ELcontainer.id = 'tmp_holder';
ELcontainer.setAttribute("style","-moz-border-radius:30px; -webkit-border-radius: 30px;");
ELcontainer.style.width = bookmarkletWidth;
ELcontainer.style.height = bookmarkletHeight;
ELcontainer.style.position = 'absolute';
ELcontainer.style.top = '10px';
ELcontainer.style.right = '10px';
ELcontainer.style.zIndex = '5000';
ELcontainer.style.padding = '15px';
ELcontainer.style.backgroundColor = '#001937';
ELcontainer.style.border = '5px solid #8f0f30';

//we need a iframe that will load data from tmp.com
var ELframe = document.createElement('iframe');
ELframe.id = 'tmp_iframe';
ELframe.src = Server + '/bookmarklet/search?u='+ CurrentUrl + '&title=' + CurrentTitle + '&client=' + CurrentVersion;
ELframe.width='100%';
ELframe.height='100%';
ELframe.setAttribute('scrolling','no');
ELframe.setAttribute('frameborder','0');
ELcontainer.appendChild(ELframe);

//next we need a div that can hold the logo
var ELlogo = document.createElement('div');
ELlogo.id = 'tmp_logo';
ELlogo.style.background = "url('http://tellmypolitician.com/images/design/TMP_LOGO.png') no-repeat";
ELlogo.style.width = '387px';
ELlogo.style.height = '100px';
ELlogo.style.margin = '0px auto';
ELlogo.style.position = 'relative';
ELlogo.style.top = '-42px';

//we need a close button as well
var ELcloseImage = document.createElement('img');
ELcloseImage.src = Server + '/images/bookmarklet/close.png';

ELcloseImage.style.position = 'absolute';
ELcloseImage.style.top = '-10px';
ELcloseImage.style.right = '-12px';
ELcloseImage.style.zIndex = '1000';

if (window.addEventListener) { 	// Mozilla, Netscape, Firefox
       ELcloseImage.addEventListener('click', closeBookmarklet, false);
}
else {	// IE
       ELcloseImage.attachEvent('onclick', closeBookmarklet);
}

ELcontainer.appendChild(ELcloseImage);
ELcontainer.appendChild(ELlogo);
document.body.appendChild(ELcontainer);

self.scrollTo(0,0);

function closeBookmarklet()
{
	//ok we need to get rid of our stuff from the page.
	var ELholder = document.getElementById("tmp_holder");
	//to do this we first hide it, because other things may not work later?
        ELholder.style.visibility="hidden";
	//then we remove it from the page.
	document.body.removeChild(ELholder);
}
