"use strict";
var _ = require("underscore");
var Reply = require("news:widget/reply/reply.js");
var Images = require("common:widget/click-image-show/click-image-show.js");
var dace = require("common:widget/ui-dace/ui-dace.js");
var rememberPos = require("news:widget/remember-pos/remember-pos.js");
var voteRender = require("common:widget/ui-vote/ui-vote.js");
var UIdrop = require("common:widget/ui-drop/ui-drop.js");
var UICopy = require("common:widget/ui-copy/ui-copy.js");

var Detail = {
  init: function() {
    var that = this;

    UICopy.init(GM.version);

    this.$content = $('#J_mainContent');
    if (!this.$content.length) {
      return;
    }
    this.render();
  },
  render: function() {
    //记住阅读位置
    rememberPos.init(GM.nid);

    //展示投票
    this.$content.find(".artical-content span._vote").each(function(idx, elem){
       voteRender("news", elem);
    });

    //新闻彩蛋
    if(GM.surprise && GM.surprise.length){
        var rand = (GM.surprise.length * Math.random())|0;
        var surpriseImg = GM.surprise[rand];
        UIdrop.create(surpriseImg, 80);
        setTimeout(function(){
            UIdrop.remove();
        }, 5000);
    }

    this.bindEvent();
    Reply.init('detail');
  },
  bindEvent: function() {
    var that = this;

    // 图片在移动端显示100%，在PC端该是多大显示多大，由于运营在后台添加图片时，设置了宽高（图片属性和style两种方式），服务端没有过滤，所以需要前端兼容
    var platform = window.navigator.platform;
    var win = platform.indexOf("Win");
    var mac = platform.indexOf("Mac");

    $(".artical-content img").each(function() {
      if (win != -1 || mac != -1) {
        $(this).css({
          "width": "auto",
          "height": "auto"
        });
      } else {
        $(this).css({
          "width": "100%",
          "height": "auto"
        });
      }
    });

    Images.renderGifs(this.$content, GM.nopic, GM.night, "news");

    // 图片点击
    this.$content.find(".artical-content").delegate("img", "click", function(e) {
      var currentTarget = e.currentTarget;
      var realSrc = null;
      if (currentTarget.getAttribute("data-src")) {
        realSrc = currentTarget.getAttribute("data-src");
        currentTarget.src = realSrc;
        currentTarget.removeAttribute("data-src");
      } else {
        if (!currentTarget.getAttribute("data-gif")) {
          var imgs = that.$content.find("img");
          var imgsNow = [];
          //去除img为头像的图片
          imgs.each(function(index,item) {
            if(!$(this).hasClass("user-icon")) {
              imgsNow.push(item)
            }
          })
          Images.createAlbum(currentTarget, imgsNow);
        }
      }

      // gif二次点击统计
      if ($(this).attr("alt").indexOf("gif") != -1) {
        dace.send("gif_secondclick");
      }

      if (currentTarget.getAttribute("data-gif")) {
        Images.handlerClickGif(currentTarget, GM.nopic);
      }
    });

  }
}

module.exports = Detail
