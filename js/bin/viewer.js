(function(){
  var Viewer;
  Viewer = {
    isTextSelected: false,
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
      pageWidth = screenWidth * 0.35;
      for (i$ = 0, to$ = pages.length; i$ < to$; ++i$) {
        i = i$;
        pages[i].style.width = pageWidth + "px";
        pages[i].style.left = screenWidth * 0.5;
        pages[i].style.marginLeft = -(pageWidth / 2) + "px";
      }
      for (i$ = 0, to$ = headers.length; i$ < to$; ++i$) {
        i = i$;
        headers[i].style.width = pageWidth + "px";
        headers[i].style.left = screenWidth * 0.5;
        headers[i].style.marginLeft = -(pageWidth / 2) + "px";
      }
      for (i$ = 0, to$ = footers.length; i$ < to$; ++i$) {
        i = i$;
        footers[i].style.width = pageWidth + "px";
        footers[i].style.left = screenWidth * 0.5;
        footers[i].style.marginLeft = -(pageWidth / 2) + "px";
      }
    },
    showFriendList: function(friendListArray){
      var length, contactList, i$, i, li;
      length = friendListArray.length;
      contactList = $("#contact-list");
      contactList.html("");
      for (i$ = 0; i$ < length; ++i$) {
        i = i$;
        li = $("<li class='contact-info'>" + "<a href='#friend-info-page'>" + "<img src='images/1.jpeg'/>" + "<span class='contact-name'>" + friendListArray[i].username + "</span> <br/> <br />" + "<span class='contact-email'>" + friendListArray[i].userId + "</span>" + "</a></li>");
        contactList.append(li);
      }
      contactList.listview("refresh");
    },
    showFriendInfo: function(friendInfo){
      var userId, username, email, mobile, userInfoList, userInfoStr;
      userId = friendInfo.userId;
      username = friendInfo.username;
      email = friendInfo.email;
      if (friendInfo.mobile != null) {
        mobile = friendInfo.mobile;
      } else {
        mobile = "未填写";
      }
      userInfoList = $("#user-info-list");
      userInfoStr = "<li>" + "<span style='width:40%;display:inline-block;'>用户ID</span>" + "<span style='color:gray;'>" + userId + "</span>" + "</li>" + "<li>" + "<span style='width:40%;display:inline-block;'>用户名</span>" + "<span style='color:gray;'>" + username + "</span>" + "</li>" + "<li>" + "<span style='width:40%;display:inline-block;'>性别</span>" + "<span style='color:gray;'>男</span>" + "</li>" + "<li>" + "<span style='width:40%;display:inline-block;'>电话号码</span>" + "<span style='color:gray;'>" + mobile + "</span>" + "</li>" + "<li>" + "<span style='width:40%;display:inline-block;'>电子邮件</span>" + "<span style='color:gray;'>" + email + "</span>" + "</li>";
      userInfoList.html(userInfoStr);
      userInfoList.listview("refresh");
    },
    setPictureSize: function(img, container){
      var page, imgWidth, imgHeight, headerHeight, footerHeight, screenWidth, screenHeight, newImgWidth, newImgHeight;
      page = $("#new-message-page");
      imgWidth = container.scrollWidth;
      imgHeight = container.scrollHeight;
      headerHeight = page.find(".header").height();
      footerHeight = page.find(".footer").height();
      screenWidth = container.clientWidth;
      screenHeight = window.innerHeight - headerHeight - footerHeight;
      console.log("window.inner-height：" + window.innerHeight);
      if (imgWidth < imgHeight) {
        newImgWidth = parseInt(screenWidth);
        newImgHeight = parseInt(imgHeight * (newImgWidth / imgWidth));
        console.log("keep width");
        console.log("new-img-width: " + newImgWidth);
        console.log("new-img-height: " + newImgHeight);
      } else {
        newImgHeight = parseInt(screenHeight);
        newImgWidth = parseInt(imgWidth * (newImgHeight / imgHeight));
        console.log("keep height");
        console.log("new-img-width: " + newImgWidth);
        console.log("new-img-height: " + newImgHeight);
      }
      img.style.width = newImgWidth + "px";
      img.style.height = newImgHeight + "px";
      console.log("img-width: " + imgWidth);
      console.log("img-height: " + imgHeight);
      console.log("header-height: " + headerHeight);
      console.log("footer-height: " + footerHeight);
      console.log("screen-width: " + screenWidth);
      console.log("screen-height: " + screenHeight);
    },
    showNewPicture: function(files){
      var self, pictureContainer, i$, to$, i, file, reader;
      self = this;
      pictureContainer = $("#create-picture");
      pictureContainer.html("");
      for (i$ = 0, to$ = files.length; i$ < to$; ++i$) {
        i = i$;
        file = files[0];
        reader = new FileReader();
        reader.onload = fn$;
        reader.readAsDataURL(file);
      }
      function fn$(e){
        var imgData, img;
        imgData = e.target.result;
        img = document.createElement("img");
        img.src = imgData;
        img.id = "picture";
        pictureContainer.html(img);
        self.setPictureSize(img, pictureContainer[0]);
      }
    },
    addTextIcon: function(picture, x, y){
      var img, picPosX, picPosY;
      img = document.createElement("img");
      img.src = "images/text_tip.png";
      img.id = "text-icon";
      picPosX = picture.offsetLeft;
      picPosY = picture.offsetTop;
      img.style.left = (picPosX + x) + "px";
      img.style.top = (picPosY + y) + "px";
      img.style.width = "50px";
      img.style.height = "50px";
      picture.parentNode.appendChild(img);
    },
    addText: function(picture, x, y){
      console.log(picture);
      this.addTextIcon(picture, x, y);
    },
    subscrbeEvents: function(){
      EventCenter.bind("Viewer:show-friend-list", EventCenter.proxy(this.showFriendList, this));
      EventCenter.bind("Viewer:show-friend-info", EventCenter.proxy(this.showFriendInfo, this));
      EventCenter.bind("Viewer:show-new-picture", EventCenter.proxy(this.showNewPicture, this));
    },
    bindEvents: function(){
      var self;
      self = this;
      $(document).on("click", "#changeAvatar", function(){
        $("#upload-file").click();
      });
      $(document).on("change", "#upload-file", function(){
        var avatar;
        avatar = $("#upload-file")[0];
        EventCenter.trigger("Controller:user-update-avatar", [avatar.files[0]]);
      });
      $(document).on("click", "#change-mobile-confirm-btn-wrapper", function(e){
        var mobile;
        mobile = $("input[name='mobile']").val();
        EventCenter.trigger("Controller:user-update-mobile", [mobile]);
      });
      $(document).on("click", "#login-btn", function(e){
        var email, password;
        email = $("#login-form input[name='email']").val();
        password = $("#login-form input[name='password']").val();
        EventCenter.trigger("Controller:user-login", [email, password]);
      });
      $(document).on("click", "#logout-confirm-button", function(e){
        EventCenter.trigger("Controller:user-logout");
      });
      $(document).on("click", "#register-btn", function(e){
        var email, password;
        email = $("#register-form input[name='email']").val();
        password = $("#register-form input[name='password']").val();
        EventCenter.trigger("Controller:user-register", [email, password]);
      });
      $(document).on("click", "a[href='#contact-page']", function(e){
        EventCenter.trigger("Controller:get-friend-list");
      });
      $(document).on("click", ".contact-info", function(e){
        var userId;
        userId = $(".contact-email").html();
        EventCenter.trigger("Controller:get-friend-info", [userId]);
      });
      $(document).on("click", ".new-picture", function(e){
        $("#new-picture").click();
      });
      $(document).on("change", "#new-picture", function(e){
        var files;
        files = this.files;
        EventCenter.trigger("Viewer:show-new-picture", [files]);
      });
      $(document).on("click", ".add-text", function(e){
        self.isTextSelected = true;
        console.log("select text");
      });
      $(document).on("click", "#picture", function(e){
        var elem, posX, posY;
        console.log(self.isTextSelected);
        if (self.isTextSelected != null) {
          elem = e.target;
          posX = e.offsetX;
          posY = e.offsetY;
          self.addText(this, posX, posY);
        }
      });
      $(document).on("scroll", "#create-picture", function(e){
        console.log(this.scrollLeft);
      });
    },
    init: function(){
      if (navigator.userAgent.match(/iPad/i) || navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPod/i)) {
        this.initMobileStyle();
      } else if (navigator.userAgent.match(/Android/i)) {
        this.initMobileStyle();
      } else {
        this.initPcStyle();
      }
      this.subscrbeEvents();
      this.bindEvents();
      $.mobile.fixedtoolbar.prototype.options.tapToggle = false;
    }
  };
  window.Viewer = Viewer;
}).call(this);
