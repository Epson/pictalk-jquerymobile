(function(){
  var Controller;
  Controller = {
    userUpdateMobile: function(mobile){
      User.updateMobile(User.userId, mobile);
    },
    uploadAvatar: function(formFileObj){
      var data, files, params;
      data = new FormData();
      files = $("#upload-file")[0].files;
      if (files != null) {
        data.append("avatarFile", files[0]);
      }
      params = {
        cache: false,
        type: 'post',
        dataType: 'json',
        url: 'users/user-upload-avatar',
        data: data,
        contentType: false,
        processData: false,
        success: function(res){
          console.log("res");
        }
      };
      $.ajax(params);
    },
    userUpdateAvatar: function(avatarUrl){},
    userLogin: function(email, password){
      User.login(email, password);
    },
    userLogout: function(){
      User.logout();
    },
    userRegister: function(email, password){
      User.register(email, password);
    },
    getFriendList: function(){
      Friend.readFriendList(User.userId);
    },
    showFriendList: function(friendListArray){
      EventCenter.trigger("Viewer:show-friend-list", [friendListArray]);
    },
    addFriend: function(friendId){
      console.log("Controller:add-friend");
      Friend.addFriend(User.userId, friendId);
    },
    getFriendInfo: function(friendId){
      Friend.getFriendInfo(friendId);
    },
    showFriendInfo: function(friendInfo){
      EventCenter.trigger("Viewer:show-friend-info", [friendInfo]);
    },
    subscribeEvents: function(){
      EventCenter.bind("Controller:user-update-avatar", EventCenter.proxy(this.uploadAvatar, this));
      EventCenter.bind("Controller:user-update-mobile", EventCenter.proxy(this.userUpdateMobile, this));
      EventCenter.bind("Controller:user-login", EventCenter.proxy(this.userLogin, this));
      EventCenter.bind("Controller:user-logout", EventCenter.proxy(this.userLogout, this));
      EventCenter.bind("Controller:user-register", EventCenter.proxy(this.userRegister, this));
      EventCenter.bind("Controller:get-friend-list", EventCenter.proxy(this.getFriendList, this));
      EventCenter.bind("Controller:show-friend-list", EventCenter.proxy(this.showFriendList, this));
      EventCenter.bind("Controller:get-friend-info", EventCenter.proxy(this.getFriendInfo, this));
      EventCenter.bind("Controller:show-friend-info", EventCenter.proxy(this.showFriendInfo, this));
    },
    init: function(){
      this.subscribeEvents();
      console.log("Controller-init");
    }
  };
  window.Controller = Controller;
}).call(this);
