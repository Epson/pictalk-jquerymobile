(function(){
  var Viewer;
  Viewer = {
    initMobileStyle: function(){
      var width, height, indexContent;
      width = screen.availWidth;
      height = screen.availHeight;
      indexContent = document.getElementById("index-content");
      indexContent.style.width = width - 20 + "px";
      indexContent.style.height = height - 30 + "px";
    },
    initPcStyle: function(){
      var screenWidth, pages, headers, footers, pageWidth, i$, to$, i;
      screenWidth = document.body.clientWidth;
      pages = document.getElementsByClassName("page");
      headers = document.getElementsByClassName("header");
      footers = document.getElementsByClassName("footer");
      pageWidth = screenWidth * 0.3;
      for (i$ = 0, to$ = pages.length; i$ < to$; ++i$) {
        i = i$;
        pages[i].style.width = pageWidth + "px";
        pages[i].style.left = screenWidth * 0.5;
        pages[i].style.marginLeft = -(pageWidth / 2) + "px";
        headers[i].style.width = pageWidth + "px";
        headers[i].style.left = screenWidth * 0.5;
        headers[i].style.marginLeft = -(pageWidth / 2) + "px";
        footers[i].style.width = pageWidth + "px";
        footers[i].style.left = screenWidth * 0.5;
        footers[i].style.marginLeft = -(pageWidth / 2) + "px";
      }
    },
    subscrbeEvents: function(){
      console.log("subscrbe-events");
    },
    init: function(){
      if (navigator.userAgent.match(/iPad/i) || navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPod/i)) {
        this.initMobileStyle();
      } else if (navigator.userAgent.match(/Android/i)) {
        this.initMobileStyle();
      } else {
        this.initPcStyle();
      }
    }
  };
  window.Viewer = Viewer;
}).call(this);
