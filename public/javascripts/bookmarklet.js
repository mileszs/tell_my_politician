//lets store all the information that we will need to send.
var CurrentUrl = escape(document.location.href);
var CurrentTitle = escape(document.title);
var CurrentVersion = '1';

//set some constants just so I don't have to change them in 5 places
var bookmarkletWidth = '489px';
var bookmarkletHeight = '257px';

//we need a place on this page to put everything.
var ELcontainer = document.createElement('div');
ELcontainer.id = 'tmp_holder';
ELcontainer.style.position='absolute';
ELcontainer.style.top='5px';
ELcontainer.style.right='0';
ELcontainer.style.zIndex = 100000;
ELcontainer.style.padding = '5px';
ELcontainer.style.backgroundColor = '#000000';
ELcontainer.style.width = bookmarkletWidth;
ELcontainer.style.height = '257px';

//we need a iframe that will load data from tmp.com
var ELframe = document.createElement('iframe');
ELframe.id = 'tmp_iframe';
ELframe.style.backgroundColor='#FFFFFF';
ELframe.src = 'http://tellmypolitician.com/search?u='+ CurrentUrl + '&title=' + CurrentTitle + '&client=' + CurrentVersion;
ELframe.width='100%';
ELframe.height='100%';
ELcontainer.appendChild(ELframe);

//next we need a div that can hold the logo
var ELlogo = document.createElement('div');
ELlogo.id = 'tmp_logo';
ELlogo.style.background ='url(http://tellmypolitician.com/images/designs/TMP_LOGO.png)';
ELlogo.style.width = bookmarkletWidth;
ELlogo.style.height = '100px';

//we need a close button as well
var ELcloseLink = document.createElement('a');
var ELcloseImage = document.createElement('img');

ELcloseImage.src = 'http://tellmypolitician.com/images/bookmarklet/close.png';

ELcloseLink.appendChild(ELcloseImage);
ELlogo.appendChild(ELcloseLink);

ELcontainer.appendChild(ELlogo);

/*
ELlogo.style.position='absolute';
ELlogo.style.top='5px';
ELlogo.style.right='0';
ELlogo.style.zIndex = 100000;
ELlogo.style.padding = '5px';
ELlogo.style.backgroundColor = '#000000';
ELlogo.style.width = '489px';
ELlogo.style.height = '257px';
*/

document.body.appendChild(ELcontainer);
