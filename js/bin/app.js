(function(){
  var app;
  app = {
    init: function(){
      Viewer.init();
      Controller.init();
    }
  };
  app.init();
  window.app = app;
}).call(this);
