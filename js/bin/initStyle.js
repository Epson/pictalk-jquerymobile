(function(){
  var loadStyleFile, initMobileStyle;
  loadStyleFile = function(fileName){
    var fileref, headobj;
    fileref = document.createElement("link");
    fileref.rel = "stylesheet";
    fileref.type = "text/css";
    fileref.href = "css/src/" + fileName + ".css";
    fileref.media = "screen";
    headobj = document.getElementsByTagName("head")[0];
    headobj.appendChild(fileref);
  };
  initMobileStyle = function(){
    var width, height, indexContent;
    width = screen.availWidth;
    height = screen.availHeight;
    indexContent = document.getElementById("index-content");
    indexContent.style.width = width - 20 + "px";
    indexContent.style.height = height - 30 + "px";
  };
  if (navigator.userAgent.match(/iPad/i) || navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPod/i)) {
    initMobileStyle();
  } else if (navigator.userAgent.match(/Android/i)) {
    initMobileStyle();
  } else {
    loadStyleFile("pc-style");
  }
  $(document).bind("mobileinit", function(){
    $.mobile.page.prototype.options.addBackBtn = true;
  });
}).call(this);
