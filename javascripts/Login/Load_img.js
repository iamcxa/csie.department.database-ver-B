var myimages=new Array()
function preloadimages(){
if (document.images){
for (i=0;i<preloadimages.arguments.length;i++){
myimages[i]=new Image()
myimages[i].src=preloadimages.arguments[i]
}}}   

preloadimages("images/top_background.png","images/logo.png","images/Mode_Full.png","images/logout.png","images/CSU_logo.png",
"images/bg_gray.jpg","images/logo_gray.png","images/bg.jpg")
