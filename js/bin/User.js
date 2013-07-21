(function(){
  var User;
  User = {
    userId: void 8,
    updateMobile: function(userId, mobile){
      var params;
      params = {
        userId: userId,
        mobile: mobile
      };
      $.post("users/user-info-update", params, function(res){
        console.log(res);
      });
    },
    login: function(email, password){
      var self, params;
      self = this;
      params = {
        email: email,
        password: password
      };
      $.post("users/user-login", params, function(res){
        if (res.err == null) {
          console.log("login successful");
          self.userId = email;
          jQuery.mobile.changePage("#show-page");
        } else {
          console.log("error occurs");
        }
      });
    },
    logout: function(){
      this.userId = void 8;
      jQuery.mobile.changePage("#index-page");
    },
    register: function(email, password){
      var self, params;
      self = this;
      params = {
        email: email,
        password: password
      };
      $.post("users/user-register", params, function(res){
        if (res.err == null) {
          console.log("register successful");
          self.userId = email;
          jQuery.mobile.changePage("#show-page");
        } else {
          console.log("error occurs");
        }
      });
    },
    init: function(){
      console.log("init");
    }
  };
  window.User = User;
}).call(this);
