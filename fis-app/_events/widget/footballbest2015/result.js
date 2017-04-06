var BaseView = require("./baseview");
var _ = require('underscore');
var Toast = require('common:widget/ui-toast/ui-toast.js');
var dace = require("common:widget/ui-dace/ui-dace.js");

var ViewResult = BaseView.extend({
  className: "result",
  events: {
    'click .share-btn' : 'showShare',
    'click .mod-mask': 'hideShare',
    'click .gotorank': 'gotoPage',
    'click .join-btn': 'joinPage'
  },
  initialize: function() {
     this.superInit();
     this.tpl = _.template($("#J-result-tpl").html());
     this.shareTpl = $("#J-share-tpl").html();
  },
  render: function() {
     var self = this;
     var fd = GM.person_fd || GM.fd;
     var isSelf = _.contains(GM.ffdtmyfd, fd);
     self.getMyData(fd, isSelf);
  },
  getMyData: function(fd, isSelf){
     var self = this;
     $.ajax({
        url : "/fifadreamteam/mydreamteam",
        type: "get",
        dataType: "json",
        data: {
          "fd": fd,
          "t": GM.t
        },
        success: function(res){
          if(res.status == 200){
            self.renderPage(res.data, isSelf);
          }else if (res.status == 400){
            location.href = "http://kanqiu.hupu.com/fifadreamteam/index";
          }else{
            Toast.toast(res.msg);
          }
        }
      });
  },
  renderPage: function(tmpData, isSelf){
     var keys = ["FORWARD", "MIDFIELD", "LEFTWINGBACK", "CENTERBACK", "RIGHTWINGBACK", "GOALKEEPER", "COACH"];
      GM.shareData.title = tmpData.config.mysharetext;
      GM.shareData.link = tmpData.config.url;
      GM.shareData.desc = "2015虎扑足球年度最佳阵容评选";
      GM.shareData.imgUrl = "http://b3.hoopchina.com.cn/games/events_img/football_logo.png";
      GM.shareData.success = function(){
          dace.send("201601fifadreamteam_share");
      }
      wx.config(GM.config);
      wx.ready(function () {
        bindWx(GM.shareData);
      });

      var myData = [];
      for(var key in tmpData){
         if(_.contains(keys, key)){
            $.each(tmpData[key], function(idx, item){
              item.id = idx;
              myData.push(item);
            });
          }
      }
      var html = this.tpl({data:myData, isSelf: isSelf});
      this.$el.html(html);
      this.$parentContainer.append(this.el);
      //只展示一次别人的结果
      if(GM.person_fd){
         GM.person_fd = null;
      }
  },
  showShare: function(){
    if(!this.$mask){
      this.$el.append(this.shareTpl);
      this.$mask = this.$el.find(".mod-mask");
    }
    this.$mask.show();
  },
  hideShare: function(){
     this.$mask.hide();
  },
  joinPage: function(){
     var href = location.href;
     href = href.substring(0, href.indexOf("?"));
     location.href = href + "#step1";

     //location.href = location.href.replace(/(\?|&)fd=\d+/, "");
  }
});

module.exports = new ViewResult();