(function(){
  var userRegister;
  userRegister = function(email, password){
    var params;
    params = {
      "email": email,
      "password": password
    };
    $.post("users/user-register", params, function(res){
      res = JSON.parse(res);
      if (res.err) {
        console.log("error occurs");
      } else {
        console.log("register successful");
        jQuery.mobile.changePage("#show-page");
      }
    });
  };
  $(document).on("click", "#register-btn", function(){
    var email, password;
    email = $('#register-form input[name="email"]').val();
    password = $('#register-form input[name="password"]').val();
    userRegister(email, password);
  });
}).call(this);
