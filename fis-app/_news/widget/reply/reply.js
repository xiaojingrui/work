var _ = require("underscore");
var Images = require("common:widget/click-image-show/click-image-show.js");
// var replyAddTips = require("common:widget/ui-headtips/ui-headtips.js");
var Warn = require("common:widget/ui-warn/ui-warn.js");
var refresh = require("common:widget/ui-refresh/ui-refresh.js");
var app = require("common:widget/ui-app/ui-app.js");
var version = require("common:widget/ui-versions/ui-versions.js");
var Toast = require("common:widget/ui-toast/ui-toast.js");
var dace = require("common:widget/ui-dace/ui-dace.js");
var popupInstance = require("./popup.js");
var purview = require("./purview.js");
var RefreshInit = null;
var warnInstance = new Warn();
// 无图模式默认图
var noPic = {
    day : "//b3.hoopchina.com.cn/games/images/news_nopic_day@2x.png",
    night: "//b3.hoopchina.com.cn/games/images/news_nopic_night@2x.png",
    gif_day: "//w3.hoopchina.com.cn/hybrid/resource/img/news_gif_nopic_2x_day.png",
    gif_night: "//w3.hoopchina.com.cn/hybrid/resource/img/news_gif_nopic_2x_night.png"
};
// 错图
var errorImgs = {
    day: "//w10.hoopchina.com.cn/hybrid/resource/img/n_err_day.png",
    night: "//w10.hoopchina.com.cn/hybrid/resource/img/n_err_night.png"
};

/**
 * 接口地址
 */
var apiUrl = (function() {
  var requestBase = '/' + GM.projectId + '/' + GM.version;
  var client = '?client=' + GM.client;
  return {
    // 获取用户信息
    getUserInfo: '/user/ajaxInfo' + client,
    // 亮评论
    light: requestBase + '/news/getLightComment' + client,
    // 全部评论
    allReqly: requestBase + '/news/getCommentH5' + client,
    // 点亮新闻评论
    lightNewsComment: requestBase + '/' + GM.leaguesEn + '/lightNewsComment' + client,
    // 内置浏览器
    lightLinkComment: requestBase + '/link/lightComment' + client
  }
})();
var Reply = {
  init: function(channel) {
    this.$replyContainer = $("#J_mReply");

    this.channel = channel || 'comment';
    this.replyTemplate = _.template($("#J_replyListTpl").html());
    this.notReply_tpl =
      '<div class="not-reply" id="J_notReplyTip"> <span class="text">还没有人发表评论哦，壮士，留个言吧！</span> </div>';

    this.hasNextPage = 0;
    this.load_ncid = 0;
    this.create_time = 0;
    this.copyContent = "";
    this.isFirstLoad = false;
    // nid是否存在，存在是新闻评论，不存在是内置浏览器
    this._isNewsComment = !!GM.nid;
    this.loadAuditStatusCount = 0;
    // 加载列表数
    this.loadListCount = 0;
    // H5 临时引用数据
    this.tmpQuoteData = {};

    this.$listTarget = null;

    //头像添加logo
    //replyAddTips.listen(this.$replyContainer.get(0))
    //弹层初始化
    popupInstance.init(this.$replyContainer, GM.is_admin, GM.version);

    this.render();
    this.popupEvent();
    this.bindEvent();
  },
  /**
   * 渲染
   */
  render: function() {
    if (this.channel == 'detail') {
      // 详细页面只加载亮评论
      this.detailLoadLightReply();
    } else {
      warnInstance.init();
      this.loadAllReply();
    }
    var _last = null;

    //点击回复区域，更新弹层位置.
    this.$replyContainer.on("click", function(e) {
      var target = e.target;
      var $target = $(target);
      var $parentTarget = $target.hasClass('.reply-list') ? $target :
        $target.parents('.reply-list');
      var type = target.getAttribute('data-type');

      // 默认评论显示
      if (type && type == "replyHide") {
        $parentTarget.removeClass('reply-list-hide');
        return;
      }
      // 默认引用评论显示
      if (type && type == "replyQuoteHide") {
        $parentTarget.find('.J_contentParent').show();
        $target.hide();
        return;
      }
      // 显示全部
      if (type && type == "replyQuoteButtonOpen") {
        $parentTarget.find('.J_quoteAllContent').show();
        $parentTarget.find('.J_quoteShortContent').hide();
        $target.hide();
        return;
      }

      //点击用户头像
      var parentNode = $target.parent();
      if ( $target.hasClass('J_preventName') || parentNode.hasClass('J_preventName') ){
            setTimeout(function() {
              popupInstance.hide();
          }, 10);
        // if (!app.isIOS) {
        //   var href = $target.attr("href") || $target.parents("a").attr("href");
        //   location.href = href;
        //   return;
        // }
      }

      //点击某条评论
      if($parentTarget.size()){
          var extra = {};
          //该评论被灭过多，回复评论隐藏
          if($parentTarget.attr('data-hide')){
            extra.hidereply = true;
          }
          //点亮点灭的状态传给评论操作框
          if($parentTarget.attr('data-lighted')){
             extra.lighted = $parentTarget.attr("data-lighted");
          }
          //再次被点击
          if ($parentTarget.hasClass('reply-active')) {
            $parentTarget.removeClass("reply-active");
          } else {
            if (_last !== null) {
              _last.removeClass("reply-active");
            }
            _last = $parentTarget;
            $parentTarget.addClass("reply-active");
          }
          var touch = e.touches ? e.touches[0] : e;
          var top = Number(touch.pageY);
          popupInstance.update(top, $parentTarget.get(0), extra);
      }else{
          //点击评论之外.
          popupInstance.hide();
      }
    });
  },
  // 评论弹层的事件绑定
  popupEvent: function() {
    var self = this;
    //回复
    popupInstance.on("reply", function(target) {
         var $target = $(target);
         var replyEvent = function() {
            var data = {
                ncid: $target.attr('data-ncid'),
                uid: $target.attr('data-uid'),
                username: $target.attr('data-username')
            }
            //临时引用内容
            self.tmpQuoteData = {
              user_name: $target.attr('data-username'),
              content: $.trim($target.find('.short-content').html())
            }
            // 新闻回复
            if(self._isNewsComment) {
                data.nid = GM.nid;
                app.send("hupu.ui.newsreply", {
                    open: true,
                    extra: data
                });
            }else{
            //其他回复
                data.hid = GM.hid;
                app.send("hupu.ui.innerreply", {
                    open: true,
                    extra: data
                });
            }
        }
        app.checkLogin(replyEvent, GM.islogin);
    });

    //举报
    popupInstance.on("report", function(target) {
        var ncid = $(target).attr('data-ncid');
        var loginEvent = function(){
            app.send("hupu.ui.report", {
                open: true,
                extra: {
                    ncid: ncid
                }
            });
        }
        app.checkLogin(loginEvent, GM.islogin);
    });

    //点亮
    popupInstance.on("light", function(target) {
        var ncid = $(target).attr('data-ncid');
        var setLightHandler = function(){
            self.setLight($(target), ncid, 1);
        };
        app.checkLogin(setLightHandler, GM.islogin);
    });

    //点灭
    popupInstance.on("rulight", function(target) {
        var ncid = $(target).attr('data-ncid');
        var setReLightHandler = function(){
            self.setLight($(target), ncid, 2);
        };
        app.checkLogin(setReLightHandler, GM.islogin);
    });
  },
  bindEvent: function() {
    var self = this;
    // 新闻ID
    if (this._isNewsComment) {
      app.register("hupu.ui.newsreplysuccess", function(msg) {
        self.getReplyData(msg);
      });
    } else {
      app.register("hupu.ui.innerreplysuccess", function(msg) {
        self.getReplyData(msg);
      });
    }

    //管理员开启管理
    if (GM.is_admin) {
      purview.init(popupInstance);
    }
  },
  // 获取用户信息，拼接评论
  getReplyData: function(msg) {
    var self = this;
    //无昵称用户获取昵称
    if (GM.user_name == '') {
      $.ajax({
        url: apiUrl.getUserInfo,
        type: "GET",
        dataType: "json",
        success: function(res) {
          if (res.result && res.is_login) {
            GM.user_name = res.result.nickname;
            GM.header = res.result.header;
            GM.puid = res.result.puid;
            GM.uid = res.result.uid;
          }
          self.appendReply(msg);
        }
      });
    } else {
      this.appendReply(msg);
    }
  },
  appendReply: function(msg) {
    // \n转br
    var content = msg.content.replace(/\n/g, '<br />');
    var replyData = [{
      "audit_status": "0",
      "from": "0",
      "ncid": msg.ncid,
      "light_count": "0",
      "unlight_count": "0",
      "uid": GM.uid,
      "user_name": GM.user_name,
      "content": content,
      "create_time": "刚刚",
      "cid": GM.cid,
      "lighted": 0,
      "format_time": "刚刚",
      "header": GM.header,
      "puid": GM.puid
    }];

    // 引用
    if (msg.isCallFromH5 == 1) {
      replyData[0].quote_data = this.tmpQuoteData;
    }


    var html = '',
      $list = $('#J_generalReply');

    //有评论的时候
    if ($list.find('.reply-list').size()) {
      html = this.replyTemplate({
        list: replyData
      });
      $list.find('.reply-list').eq(0).before(html);

    //无评论的时候
    } else {
      html = this.replyTemplate({
        title: '最新评论',
        list: replyData
      });
      $list.html(html);
    }
  },
  /**
   * 新闻详情亮评论加载
   */
  detailLoadLightReply: function() {
    var self = this;

    $.ajax({
      url: apiUrl.light,
      type: "GET",
      dataType: "json",
      data: {
        nid: GM.nid,
        t: (new Date().getTime())
      },
      success: function(data) {
        if (data && data.light_comments.length) {
          var hasLightShow = false
          $(data.light_comments).each(function(idx, item){
              if( (typeof item.is_delete === "undefined" && item.audit_status != "1") || (item.audit_status === "1" && (GM.cid == item.cid || GM.uid == item.uid) )  ){
                  hasLightShow = true
              }
          });
          //是否有可展示部分
          if(hasLightShow){
              var html = self.replyTemplate({
                title: '这些评论亮了',
                list: data.light_comments
              });

              $('#J_brightReply').html(html);
              //图片加载失败，自动替换成默认图
              Images.listenImagesReplaceErr($('#J_brightReply').find(
                'img'));
            }

          //全部评论展示
          if (GM.replies > 0) {
            $('#J_replayButtonInner').show();
          }

        } else {
          $('#J_brightReply').empty();
        }
        self.bridgeReady();
      }
    });
  },

  bridgeReady: function(){
      //阅读设置
      HupuBridge.register("hupu.ui.updatefontsize", function(res){
          $(".artical-content").css({
              "font-size": res.fontsize + "px"
          });
          $(".reply-content").css({
              "font-size": (res.fontsize - 2) + "px"
          });
      });

      //夜间模式
      HupuBridge.register("hupu.ui.updateNightMode", function(res){
          if(!!parseInt(res.night)){
              $("body").addClass("night");
              //替换图片
              $("body").find("img").each(function(idx,item){
                  if(~item.src.indexOf("news_nopic_day@2x.png")){
                      item.src = noPic.night;
                  }
                  if(~item.src.indexOf("n_err_day.png")){
                      item.src = errorImgs.night;
                  }
                  if(~item.src.indexOf("news_gif_nopic_2x_day.png")){
                      item.src = noPic.gif_night;
                  }
              });
          }else{
              $("body").removeClass("night");

              //替换图片
              $("body").find("img").each(function(idx, item){
                  if(~item.src.indexOf("news_nopic_night@2x.png") || ~item.src.indexOf("bbs-night-nopic.png")){
                      item.src = noPic.day;
                  }
                  if(~item.src.indexOf("n_err_night.png")){
                      item.src = errorImgs.day;
                  }
                  if(~item.src.indexOf("news_gif_nopic_2x_night.png")){
                      item.src = noPic.gif_day;
                  }
              });
          }
      });
  },
  /**
   * 第一次加载
   */
  loadAllReply: function(complete) {
    var self = this;

    var data = {
      top_ncid: GM.top_ncid,
      t: (new Date().getTime())
    };

    // 新闻ID
    if (this._isNewsComment) {
      data.nid = GM.nid;
    } else {
      data.hid = GM.hid;
    }

    $.ajax({
      url: apiUrl.allReqly,
      type: "GET",
      dataType: "json",
      timeout: 5000,
      data: data,
      success: function(res) {
        if (res) {
          var $brightReply = $('#J_brightReply');
          var html = '';

          // 标题
          if (res.news) {
            html = _.template($("#J_titleTpl").html(), res.news);

            $('#J_replyTitle').html(html);
          }
          // 消息跳转
          if (res.top_comment && res.top_comment.length) {
            html = self.replyTemplate({
              list: res.top_comment
            });

            $('#J_jumpReply').html('<div class="jump-reply">' + html +
              '</div>');
          }

          // 亮评论
          if (res.light_comments && res.light_comments.length) {

            var hasLightShow = false
            $(res.light_comments).each(function(idx, item){
               if( (typeof item.is_delete === "undefined" && item.audit_status != "1") || (item.audit_status === "1" && (GM.cid == item.cid || GM.uid == item.uid) )  ){
                  hasLightShow = true
               }
            });
              //是否有可展示部分
            if(hasLightShow){
                html = self.replyTemplate({
                  title: '这些评论亮了',
                  list: res.light_comments
                });
                $brightReply.html(html);
            }
            // 普通评论删除、刷新
          } else {
            $brightReply.html('');
          }

          // 普通评论
          if (res.data && res.data.length) {
            html = self.replyTemplate({
              title: '最新评论',
              list: res.data
            });

            self.loadListCount += self.checkAuditStatus(res.data);
            self.hasNextPage = res.hasNextPage;
            self.load_ncid = res.data[res.data.length - 1].ncid;
            self.create_time = res.data[res.data.length - 1].create_time;

            // 违禁字
            if (!self.hasNextPage && self.loadListCount <= 0) {
              $('#J_generalReply').html(self.notReply_tpl);
            } else {
              $('#J_generalReply').html(html);
            }

            if (self.loadListCount < 10 && self.hasNextPage) {
              self.loadMoreReply('auditStatus');
              self.loadListCount = 0;
            }
          } else {
            $('#J_generalReply').html(self.notReply_tpl);
          }

          //图片加载失败，自动替换成默认图
          Images.listenImagesReplaceErr($('#J_mReply').find('img'));

          setTimeout(function() {
            complete && complete();
          }, 500);

          // 加载事件执行多次
          if (!self.isFirstLoad) {
            self.scrollBind();
            self.isFirstLoad = true;
          }

          return;
        }
        warnInstance.show();
      },
      error: function(err) {
        if (complete) {
          return;
        }
        warnInstance.rollCallback = function() {
          self.loadAllReply();
        };
        warnInstance.show();
      }
    });
  },
  /**
   * 滚动事件
   */
  scrollBind: function() {
    var self = this;

    var firstMore = (this.hasNextPage ? true : false);

    RefreshInit = refresh({
      contentEl: '#J_replyWrap',
      isRefresh: true,
      distanceToRefresh: 0,
      loadingStyle: 2,
      isLoadingMore: firstMore,
      refreshCallback: function(complete) {
        // android QQ浏览器新闻闪动
        if(version.lte(GM.version,"7.0.6") && app.isAndroid){
            setTimeout(function() {
                complete && complete();
                window.location.reload();
            }, 500);
            return;
        }
        self.loadAllReply(complete);
      },
      loadingMoreCallback: function(complete) {
        self.loadMoreReply(complete);
      }
    });
  },
  /**
   * 加载更多评论
   */
  loadMoreReply: function(complete) {
    var self = this;

    var data = {
      ncid: this.load_ncid,
      create_time: this.create_time
    }

    // 新闻ID
    if (this._isNewsComment) {
      data.nid = GM.nid;
    } else {
      data.hid = GM.hid;
    }

    $.ajax({
      url: apiUrl.allReqly,
      type: "GET",
      dataType: "json",
      data: data,
      //timeout : 5000,
      success: function(res) {
        if (res && res.data.length) {
          var html = self.replyTemplate({
            list: res.data
          });

          self.hasNextPage = res.hasNextPage;
          self.load_ncid = res.data[res.data.length - 1].ncid;
          self.create_time = res.data[res.data.length - 1].create_time;

          // 评论20条状态都是在待审核,再请求2次之后不做处理
          if ($.trim(html) == "") {
            self.loadAuditStatusCount++;
            if (self.loadAuditStatusCount >= 3) {
              if (complete && complete == 'auditStatus') {
                if (!$('#J_generalReply .reply-list').length) {
                  $('#J_generalReply').html(self.notReply_tpl);
                }
              } else {
                complete();
              }
              return;
            }
            self.loadMoreReply(complete);
            return;
          }

          self.loadAuditStatusCount = 0;

          $('#J_generalReply .reply-inner').append(html);

          //图片加载失败，自动替换成默认图
          Images.listenImagesReplaceErr($('#J_generalReply').find('img'));

          if (self.hasNextPage) {
            complete && complete();
          } else {
            if (complete && complete == 'auditStatus') {
              $(window).trigger('loadMoreCallback', ['finish']);
            } else {
              complete('finish');
            }
            $('#J_generalReply').append(
              '<div class="has-more-reply">没有更多评论了</div>');
          }

        }

      },
      error: function() {
        Toast.toast('加载失败');
        complete && complete();
      }
    });
  },
  //验证评论状态，返回正常评论数量
  checkAuditStatus: function(data) {
    var count = 0;

    _.each(data, function(element, index, list) {
      if (element.audit_status != 1 || GM.cid == element.cid || GM.uid ==
        element.uid) {
        count++;
      }
    });

    return count;
  },
  /**
   * 点亮点灭
   * @param $target 评论容器
   * @param ncid 评论nicd
   * @param type 1为点亮，2为点灭
   */
  setLight: function($target, ncid, type) {
    var self = this;

    var data = {
        ncid: ncid,
        type: type,
        token: GM.token
      },
      url = apiUrl.lightNewsComment;

    // 新闻ID
    if (this._isNewsComment) {
      data.nid = GM.nid;
    } else {
      data.hid = GM.hid;
      url = apiUrl.lightLinkComment;
    }

    $.ajax({
      url: url,
      type: "POST",
      dataType: "json",
      data: data,
      success: function(res) {
        if (res.error && res.error.text) {
          Toast.toast(res.error.text);
          return;
        }

        var count = -1;
        var tipText = '-1';

        if (type && type === 1) {
          count = 1;
          tipText = '+1';
          $target.attr('data-lighted', 1);
        } else {
          $target.attr('data-lighted', 2);
        }

        var $lightCount = $target.find('.J_ligthCount');
        if (res.result == 1) {
          $lightCount.text(parseInt($lightCount.text()) + count);
          Toast.count($target, tipText, "right");
        }
      }
    });
  }
}

module.exports = Reply;
