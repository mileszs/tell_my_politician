//first things first we need a place on this page to put everything.
var ELcontainer = document.createElement('div');

ELcontainer.id = 'tmp_holder';
ELcontainer.style.position='absolute';
ELcontainer.style.top='5px';
ELcontainer.style.right='0';
ELcontainer.style.zIndex = 100000;
ELcontainer.style.padding = '5px';
ELcontainer.style.backgroundColor = '#000000';
ELcontainer.style.width = '489px';
ELcontainer.style.height = '257px';

var CurrentUrl = escape(document.location.href);
var CurrentTitle = escape(document.title);
var CurrentVersion = '1';

var ELframe = document.createElement('iframe');
ELframe.id = 'tmp_iframe';
ELframe.style.backgroundColor='#FFFFFF';
ELframe.src = 'http://tellmypolitician.com/search?u='+ CurrentUrl + '&title=' + CurrentTitle + '&client=' + CurrentVersion;
ELframe.width='100%';
ELframe.height='100%';
ELcontainer.appendChild(ELframe);
document.body.appendChild(ELcontainer);

