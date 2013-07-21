(function(){
  var Friend;
  Friend = {
    readFriendList: function(userId){
      var params;
      params = {
        userId: userId
      };
      $.get("friends/read-friend-list", params, function(res){
        res = JSON.parse(res);
        EventCenter.trigger("Controller:show-friend-list", [res.friends]);
      });
    },
    addFriend: function(userId, friendId){
      var params;
      console.log("Friend:add-friend");
      params = {
        userId: userId,
        friendId: friendId
      };
      console.log(params);
      $.post("friends/create-friend", params, function(res){
        res = JSON.parse(res);
        console.log(res);
      });
    },
    init: function(){
      console.log("Friend init");
    }
  };
  window.Friend = Friend;
}).call(this);
