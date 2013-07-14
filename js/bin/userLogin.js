(function(){
  var userLogin;
  userLogin = function(email, password){
    var params;
    params = {
      "email": email,
      "password": password
    };
    $.post("users/user-login", params, function(res){
      res = JSON.parse(res);
      if (res.err) {
        console.log("error occurs");
      } else {
        console.log("login successful");
        jQuery.mobile.changePage("#show-page");
      }
    });
  };
  $(document).on("click", "#login-btn", function(){
    var email, password;
    email = $('#login-form input[name="email"]').val();
    password = $('#login-form input[name="password"]').val();
    userLogin(email, password);
  });
}).call(this);
