var app = require("common:widget/ui-app/ui-app.js");
var Store = require("common:widget/ui-store/ui-store.js");
var Images = require("common:widget/click-image-show/click-image-show.js");
var Toast = require("common:widget/ui-toast/ui-toast.js");
var appVersion = app.getVersion(GM.version);
var _ = require("underscore");

var zanMarkName = "hupu_zan_toggle";
var zanToggle = new Store(zanMarkName);
var toggleStore = {
  saveClosed: function(){
    zanToggle.set(1);
  },
  isTipsClosed: function(){
    return !!parseInt(zanToggle.get());
  }
}

var zanController = {
  init: function(opts, isShowTips){
    this.type = opts.type;
    this.typeid = opts.typeid;
    this.fid = opts.fid;
    this.nickname = opts.nickname;
    this.userCount = opts.userCount;
    this.goldCount = opts.goldCount;

    this.userTpl = [
      '<span class="zan-userimg">',
         '<img src="<@=userImg@>" alt="<@=nickname@>" class="user-icon J-user-avatar-img" />',
       '<span class="mod-mask mask"></span>',
     '</span>'
    ].join("");

    this.textTpl = '已有<span class="zan-count"><@=userCount@></span>个JRs赞赏了<@=goldCount@>虎扑币 &gt;'
    this.userListTpl = this.userTpl + this.textTpl;

    this.container = $("#J-zan-container");
    if(isShowTips && !toggleStore.isTipsClosed()){
      var html = [
        '<div class="zan-tips">',
          '<div class="zan-close" dace-node="reward_tips"></div>',
          opts.tips,
        '</div>'
      ].join("");
      this.container.append(html);
    }
    this.bindEvent();
  },
  bindEvent: function(){
    var self = this;

    Images.listenImagesReplaceErr(this.container.find("img"));

    //关闭tips
    this.container.delegate(".zan-close","click",function(e){
         toggleStore.saveClosed();
         $(e.currentTarget).parent().remove();
    });

    var bridgeParam = {
        type: this.type,
        typeid : this.typeid,
        nickname: this.nickname
    };
    if(this.fid){
        bridgeParam.fid = this.fid;
    }
    //赞赏个人
    this.container.delegate(".J-zan","click", function(e){
      app.send("hupu.ui.admire", bridgeParam);
    });

    //赞赏列表
    this.container.delegate(".J-zanlist","click", function(e){
        app.send("hupu.ui.admirelist", bridgeParam);
    });

    //bridge ready time.
    setTimeout(function(){
        //赞赏回调
        app.register("hupu.ui.admiresuccess", function(res){
          //低版本或者新闻论坛正文赞赏
          if(appVersion.lte("7.0.12") || res.type == 'bbs' || res.type == 'news'){
              try{
                  self.appendUser({
                    nickname: res.nickname,
                    amount: parseInt(res.amount, 10),
                    userImg: res.userImg || 'http://b1.hoopchina.com.cn/games/images/man.jpg'
                  });
              }catch(e){}
          } else{
              $(document).trigger('bbs:replyzan', [res]);
          }
        });
    }, 150);
  },
  appendUser: function( user ){
    var userContainer = this.container.find(".J-zanlist");
    var userHtml = _.template(this.userTpl, user);
    var textHtml = _.template(this.textTpl, {
        userCount: this.userCount + 1,
        goldCount: this.goldCount + user.amount
    });

    switch (this.userCount) {
      case 0:
        var html = [
          '<br /><div class="zan-list J-zanlist" dace-node="reward_tips">',
            userHtml,
            '<span class="J-zan-detail">',
              textHtml,
            '</span>',
          '</div>'
        ].join("");
        this.container.find(".J-zan").after(html);
        break;
      case 1:
      case 2:
        userContainer.prepend(userHtml);
        userContainer.find(".J-zan-detail").html(textHtml);
        break;
      default:
        userContainer.find(".zan-userimg").last().remove();
        userContainer.prepend(userHtml);
        userContainer.find(".J-zan-detail").html(textHtml);
    }
    this.userCount += 1;
    this.goldCount += user.amount;
  }
}

module.exports = zanController
