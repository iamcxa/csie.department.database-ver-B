/*
Copyright by Audi 2006
http://audi.tw
http://www.carousel.com.tw
�w�����Ω�L�v�γ~�����A�ýФŲ��������v�ŧi

*/

var omitformtags=["input", "textarea", "select"];
function disableselect(e){for (i = 0; i < omitformtags.length; i++){if (omitformtags[i]==(e.target.tagName.toLowerCase()))return;}return false}
function reEnable(){return true}document.write('<div style="position:absolute;visibility:visible;top:-3000px;left:-3000px;"><form name="_hiddenFrom"><input type="text" value="���!�A��Ctrl-A��!" name="_hiddenText"></form></div>');
if (typeof document.onselectstart=="undefined"){document.onmousedown=disableselect;document.onmouseup=reEnable;}else{document.onmousedown=new Function("return false");document.onmouseup=new Function("return false");}
document.onselectstart=new Function("return false");document.onselect=new Function("return false");document.oncontextmenu=new Function("return false");onload=document._hiddenFrom._hiddenText.focus();