
var _ = require("underscore");
var dace = require("common:widget/ui-dace/ui-dace.js");
var Toast = require("common:widget/ui-toast/ui-toast.js");
var app = require("common:widget/ui-app/ui-app.js");
var emoji = require("common:widget/emoji/emoji.js");
var voteRender = require("common:widget/ui-vote/ui-vote.js");
var Tool = require("common:widget/ui-tools/ui-tools.js");
//var replyAddTips = require("common:widget/ui-headtips/ui-headtips.js");

var UIdrop = require("common:widget/ui-drop/ui-drop.js");
var UICopy = require("common:widget/ui-copy/ui-copy.js");

var appVersion = app.getVersion(GM.version);
var popupInstance = require("./popup.js");
var LoadInstance = require("./load.js");
var LoadingInstance = require("./loading.js");
var StoreInstance = require("./store.js");
var Images = require("common:widget/click-image-show/click-image-show.js");
var refresh = require("bbs:widget/ui-refresh-page/ui-refresh-page.js");
var hasTouch = "ontouchend" in window;
// 获取事件
var eventName = hasTouch ? "touchend" : "click";
// 论坛无图模式默认图
var noPic = {
    day : "//b3.hoopchina.com.cn/games/images/news_nopic_day@2x.png",
    night: "//w3.hoopchina.com.cn/games/images/bbs-night-nopic.png"
};
//错图
var errorImgs = {
    day: "//w10.hoopchina.com.cn/hybrid/resource/img/n_err_day.png",
    night: "//w10.hoopchina.com.cn/hybrid/resource/img/n_err_night.png"
};
//判断是否支持webp
var checkWebp=0;
//接口请求
var constRequest = {
    content: "/" + GM.projectId +"/"+ GM.version + "/threads/getsThreadInfo",
    light: "/" + GM.projectId +"/"+ GM.version + "/threads/getsThreadLightReplyList",
    reply: "/" + GM.projectId +"/"+ GM.version + "/threads/getsThreadPostList",
    addRecommend: "/" + GM.projectId +"/"+ GM.version + "/threads/threadRecommand",
    addLight: "/" + GM.projectId +"/"+ GM.version + "/threads/replyLight",
    addRuLight: "/" + GM.projectId +"/"+ GM.version + "/threads/replyUnlight",
    getLastPage: "/" + GM.projectId +"/"+ GM.version + "/threads/getPostsLastInfo",
    changeRecommendStatus: "/" + GM.projectId + "/" + GM.version + "/threads/changeRecommendStatus"
};
//论坛
var replyPage = {
    init: function(){
        //论坛浏览数统计, 用图片模拟发送, By FHY.
        Tool.ImgMockGET("//msa.hupu.com/thread_hit?tid=" + GM.tid);
        this.allReplyContainer = $("#J-all-reply");
        this.pageContainer = $("#J-page-container");
        this.lightContainer = $("#J-light-container");
        this.replyContainer = $("#J-reply-container");
        this.errorContainer = $("#J-page-error");
        this.loadMoreReplyBtn = $("#J-touch-addmorepost");
        this.replyTamplate =  _.template($("#J-reply-tpl").html());

        UICopy.init(GM.version); //临时加入.
        //展示投票
        $(".J-article-content span._vote").each(function(idx, elem){
           voteRender("bbs", elem);
        });

        //论坛彩蛋
        if(GM.surprise && GM.surprise.length){
            var rand = (GM.surprise.length * Math.random())|0;
            var surpriseImg = GM.surprise[rand];
            UIdrop.create(surpriseImg, 80);
            setTimeout(function(){
                UIdrop.remove();
            }, 5000);
        }

        //头像添加logo
        //replyAddTips.listen(this.allReplyContainer.get(0))
        //传入点亮权限
        //传入赞赏权限
        popupInstance.init(this.allReplyContainer, {
            hasRulight: !GM.islogin || GM.unlights_enable,
            hasZan: GM.hasPraise
        });
        LoadingInstance.init();

        this.page = GM.last ? this.getPage() : (GM.page || this.getPage());
        this.totalPage = GM.totalPage;
        this.lastPid = null;
        this.lastPostCount = 0;
        this.recommendCount = 0;

        this.isLoadMain = false;
        this.loadingReply = false;
        this.titleFixedStatus = false;

        this.titleTop = 0;

        this.bindEvent();
        var self = this;
        //判断是否支持webp
        this.check_webp_feature("lossy",function(lossy,result) {
            if(result) {
                checkWebp=1;
            }
            // 去掉新帖发布之后的倒计时 20160804 Edit By FHY.
             if(GM.isNew){
             //  dace.send("countdownstart");
             //  LoadingInstance.show(function(){
             //       dace.send("countdownend");
                    if($(".detail-error").size()){
                        $(".detail-error").find("p").html("抱歉！服务端数据有延迟<br />稍后重新刷新列表即可查看");
                        dace.send("postfail");
                    } else {
                        self.startPage();
                    }
            //   }, 0);
               return;
            }
            self.startPage();
        })
    },
    startPage: function(){
        //页面报错，不执行后续代码.
        if(GM.wasError) return;
        app.send("hupu.ui.bbstimekick");
        var self = this;

        var pageCallBack = function(page, status){
            self.loadReply(page, status, function(){
                if(appVersion.eq("7.0.5")){
                    self.initScroll();
                }else{
                    //如果是从下一页返回来的
                    if(GM.prev){
                        setTimeout(function(){
                            var docHeight = $(document).height();
                            window.scrollTo(0, docHeight);
                        }, 200);
                    }
                }
                self.bridgeReady();
            });
        }
        if(this.page === 0 || this.page === 1){
            this.loadMain(function(){
                pageCallBack(1, 3);
            });
        } else{
            pageCallBack(this.page, 2);
        }
    },
    /**

    */
    bridgeReady: function(){
        //阅读设置
        HupuBridge.register("hupu.ui.updatefontsize", function(res){
            $(".J-article-content").css({
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
                $(".mod-mask").css({"background-color": "rgba(0, 0, 0, 0.3)"});
                //替换图片
                $("body").find("img").each(function(idx, item){
                    if(~item.src.indexOf("news_nopic_day@2x.png")){
                        item.src = noPic.night;
                    }
                    if(~item.src.indexOf("n_err_day.png")){
                        item.src = errorImgs.night;
                    }
                });
            }else{
                $("body").removeClass("night");
                $(".mod-mask").css({"background-color": "rgba(0, 0, 0, 0)"});
                //替换图片
                $("body").find("img").each(function(idx, item){
                    if(~item.src.indexOf("bbs-night-nopic.png")){
                        item.src = noPic.day;
                    }
                    if(~item.src.indexOf("n_err_night.png")){
                        item.src = errorImgs.day;
                    }
                });
            }
        });
    },
    /**
     * 设置页面最小高度
     */
    updateBodyHeight: function(){
        var docH = $(document).height();
        var winH = $(window).height();
        var self = this;
        if(docH < winH){
            $("body").css("height",winH);
        } else{
            //尝试修复页面高度引起的底部留白问题.
            if(app.isIOS){
                $("body").css("height", docH);
                //读取reply高度，触发重绘.
                var replyHeight = self.replyContainer.height();
            }
            setTimeout(function(){
                $("body").css("height","");
            }, 0);
        }
    },
    /**
     * 获取页面页码
     * @return {number} [页码]
     */
    getPage: function(){
        var pn = 0;
        var re = /(#|&)pn=(\d+)/i;
        var match = location.hash.match(re);
        if(match && match.length >= 3){
            pn = parseInt(match[2], 10);
        }
        return pn;
    },
    /*
     * PC的默认表情
     */
    isSmile: function(url){
        return (url.indexOf("b1.hoopchina.com.cn/post/smile") !== -1
            || url.indexOf("b3.hoopchina.com.cn/post/smile") !== -1);
    },
    /*
     * 夜间模式 or 日间模式
     * 默认图
     */
    filterBBS: function(content){
        var self = this;
        if($.type(content) === "string"){
            content = emoji.trans(content);
            if(GM.nopic){
                var defaultPic = GM.night ? noPic.night: noPic.day;
                var match = /<img[^<>]*?src=\"[^<>]*?>/gi;
                var result = content.replace(match, function(img){
                    var srcs = img.match(/src=[\"\']([^\"]*?)[\"\']/gi);
                    var src = srcs && srcs.length ? srcs[0] : "";
                    var res = img;
                    if(src && !self.isSmile(src) ){
                        src = src.substr(5, src.length-6);
                        res = img.replace(src, defaultPic);
                        res = res.replace(/<img/gi, "<img data-src='"+ src +"'");
                    }
                    return res;
                });
                return result;
            } else{
                return content;
            }
        } else{
            return "";
        }
    },
    /**
     * 初始化评论翻页
     */
    initScroll: function(){
        if(this.totalPage == 1) return;
        var self = this;

        function pullDownAction() {
            dace.send("downTurnpage");
            popupInstance.hide();
            self.loadReply(self.page - 1, 1);
        }

        function pullUpAction() {
            dace.send("upTurnpage");
            popupInstance.hide();
            self.loadReply(self.page + 1, 1);
        }
        this.refresher = refresh({
            contentEl: '#J-scroll-wrapper',
            isRefresh: true,
            isLoadingMore: true,
            isLast: (self.page >= self.totalPage),
            refreshCallback: function(complete) {

                setTimeout(function() {
                    if (self.loadingReply) {
                        complete((self.page >= self.totalPage) ? "finish" : "loading");
                    } else {
                        var isLast = self.page - 1 >= self.totalPage;
                        complete(isLast ? "finish" : "loading");
                        pullDownAction();
                    }
                }, 500);
            },
            loadingMoreCallback: function(complete) {
                setTimeout(function() {
                    if (self.loadingReply) {
                        complete((self.page >= self.totalPage) ? "finish" : "loading");
                    } else {
                        var isLast = self.page + 1 >= self.totalPage;
                        complete(isLast ? "finish" : "loading");
                        pullUpAction();
                    }
                }, 500);
            }
        });

    },
    // 正文接口
    loadMain: function(callback){
        var self = this;
        //已经加载，show出来
        // if(!this.isLoadMain){
        //     this.isLoadMain = true;
            this.bindArticalEvent();
            //只看楼主不显示亮回复
            if(!GM.isOwner){
               this.loadLight();
            }else{
               this.showDetailBottomSupport();
               setTimeout(function() {
                var generalReply = $(".general-reply-container");
                if(generalReply.find(".title").size()) {
                    generalReply.find(".title").get(0).scrollIntoView();
                }
               },500)

            }
        //}
        this.pageContainer.show();
        this.lightContainer.show();

        // var pics = $(".article-content").find("img.lazy");
        // //有图模式下执行（wify）防止
        // if(!GM.nopic) {
        //     pics.each(function(idx,img) {
        //         self.imgsCounts(this);
        //     });

        // }

        callback && callback();

    },
    bindArticalEvent: function(){
        var self = this;
        Images.renderGifs(this.pageContainer, GM.nopic, GM.night, "bbs");
        //图片点击事件
        this.pageContainer.find(".J-article-content img").not(".emoji").on("click", function(e){
            var currentTarget = e.currentTarget;
            //点击gif图的时候计算图片大小，防止gif角标错位
            if(currentTarget.getAttribute("data-gif") && currentTarget.getAttribute("data-src")) {
                var realSrc = currentTarget.getAttribute("data-src");
                $(currentTarget).on("load", function() {
                  self.imgsCounts(currentTarget);
                });
                currentTarget.src = realSrc;

            }
            if(currentTarget.getAttribute("data-src")){
                var realSrc = currentTarget.getAttribute("data-src");
                currentTarget.src = realSrc;
                currentTarget.removeAttribute("data-src");
                return false;
            } else{
                if(!currentTarget.getAttribute("data-gif")){
                    var imgs = self.pageContainer.find(".J-article-content img");
                    Images.createAlbum(currentTarget, imgs);
                } else{
                    Images.handlerClickGif(currentTarget, GM.nopic);
                }
            }
        });
    },
    updateListCert: function(list){
        if(_.isArray(list) && list.length){
            var self = this;
            list.map(function(item){
                if(item.certurl && !_.isEmpty(item.certuser)){
                    item.cert = self.getUserCert(item.certuser)
                }
            })
        }
        return list
    },
    getUserCert: function( cert ){
        var retCert = {}
        if(!_.isEmpty(cert["1"]) && !_.isEmpty(cert["2"])){
            retCert.type = 3
            retCert.info = [cert["1"].cert_info, cert["2"].cert_info].join("、")
        } else{
            if(!_.isEmpty(cert["1"])){
                retCert.type = 1
                retCert.info = cert["1"].cert_info
            }
            if(!_.isEmpty(cert["2"])){
                retCert.type = 2
                retCert.info = cert["2"].cert_info
            }
        }
        retCert.image = this.getCertImage(retCert.type)
        return retCert
    },
    getCertImage: function(type){
        var mode = GM.night
        var merge = mode == 1 ? 'night' : 'day'
        var src = ""
        switch (type) {
            case 1:
                src = "//w10.hoopchina.com.cn/hybrid/resource/cert/author_"+ merge +".png"
                break;
            case 2:
                src = "//w10.hoopchina.com.cn/hybrid/resource/cert/official_"+ merge +".png"
                break;
            case 3:
                src = "//w10.hoopchina.com.cn/hybrid/resource/cert/merge_"+ merge +".png"
                break;
        }

        return src
    },
    // 亮回复接口
    loadLight: function(){
        var self = this;
        LoadInstance.pending({
            url: constRequest.light,
            type: "GET",
            dataType:"json",
            data: {
                "tid": GM.tid,
                "fid": GM.fid,
                "client": GM.client,
                "nopic": GM.nopic,
                "night": GM.night,
                "webp":checkWebp
            }
        }, function(data){
            if(data.status === 200 && data.list && data.list.length){
                var lightHtml = self.replyTamplate({
                    "title":"这些回复亮了",
                    "list": self.updateListCert(data.list),
                    "fliter": self.filterBBS.bind(self),
                    "author_puid": GM.author_puid,
                    "page":""
                });
                self.lightContainer.html(lightHtml);
                //self.titleFixed();
                Images.renderGifs(self.lightContainer, GM.nopic, GM.night, "bbs");
            }
            //亮回复后显示
            self.showDetailBottomSupport();
        });
    },
    showDetailBottomSupport: function(){
        $("#J_bottom_support").show();
    },
    // 全部回复接口
    loadReply: function(page, scrollStatus, callback){
        if(!page) return;
        if(page < 1) return;
        if(page > this.totalPage) return;
        if(this.loadingReply) return;

        var direction = page > this.page ? "down" : "up";
        this.loadingReply = true;
        var self = this;

        LoadInstance.pending({
            url: constRequest.reply,
            type: "GET",
            dataType:"json",
            data: {
                "tid": GM.tid,
                "fid": GM.fid,
                "postAuthorPuid": GM.isOwner,
                "page": page,
                "client": GM.client,
                "nopic":GM.nopic,
                "night": GM.night,
                "webp":checkWebp
            },
            noCache: (page == this.totalPage)
        }, function(res){
            if(res.status === 200){
                //合并帖子后，无回复的时候提示用户返回帖子列表页.
                if(!res.result.list && !res.result.list.length){
                    Toast.alert({
                        content:"回帖数据异常，请退出重进",
                        align: "left",
                        submitText: "确定",
                        submitHandler: function(){
                            //点击确定, 返回到native的帖子列表页.
                            app.send("hupu.ui.back");
                        }
                    });
                    return
                }
                var data = {
                    "list": self.updateListCert(res.result.list)||[],
                    "fliter": self.filterBBS.bind(self),
                    "author_puid":GM.author_puid,
                    "title":"",
                    "page": page
                };
                if(page === 1){
                    data.title = "全部回复";
                    //self.loadMain();
                }else{
                    self.pageContainer.hide();
                    self.lightContainer.hide();

                }
                //获取最后一页的帖子ID
                if(page === self.totalPage){
                    var lastPost = data.list.length > 0 ? data.list[data.list.length - 1]:null;
                    self.lastPid = lastPost && lastPost.pid ? lastPost.pid : null;
                    self.lastPostCount = data.list.length;
                }
                var replyHtml = self.replyTamplate(data);
                self.replyContainer.empty().html(replyHtml);

                Images.renderGifs(self.replyContainer, GM.nopic, GM.night, "bbs");
                //滚动状态，1为翻页，2为跳页，可以不设置.
                switch (scrollStatus) {
                    case 1:
                        if (direction == "down") {
                            self.replyContainer.find("dl:first-child")[0].scrollIntoView();
                        } else {
                            self.replyContainer.find("dl:last-child")[0].scrollIntoView();
                        }
                        break;
                    case 2:
                        window.scrollTo(0, 0);
                        break;
                }

                //手动延迟执行
                setTimeout(function(){
                    self.updateBodyHeight();
                    self.titleFixed();

                    self.titleTop = self.replyContainer.find(".general-reply .title").offset().top;
                    //战报内帖子链接跳转过来直接跳到全部回复第一条
                    if(location.href.indexOf("allreply") != "-1"){
                        $(window).scrollTop(self.titleTop);
                        console.log(self.titleTop)
                    }
                }, 200);

                self.loadingReply = false;
                if(GM.pid){
                    self.findFloor(GM.pid);
                    GM.pid = 0;
                }

                callback && callback();

                self.updatePage(page, (scrollStatus === 4));
            }
        });
    },
    // 帖子推荐
    addRecommend: function(callback){
        var self = this;
        var loginEvent = function(){
            $.ajax({
                url: constRequest.addRecommend,
                type:"POST",
                data:{
                    "tid": GM.tid,
                    "client": GM.client
                },
                dataType:"json",
                success: function(res){
                    if(res.status === 200){
                       StoreInstance.addPost(GM.tid);
                    }
                    var count = self.recommendCount + 1;
                    callback && callback(count);
                }
            });
        };
        app.checkLogin(loginEvent, GM.islogin);
    },
    //回帖点亮
    addLight: function(pid, callback){
        var loginEvent = function(){
            $.ajax({
                url:constRequest.addLight,
                type:"POST",
                data:{
                    "tid": GM.tid,
                    "fid": GM.fid,
                    "pid": pid,
                    "client": GM.client
                },
                dataType:"json",
                success: function(res){
                    if(res && res.status === 200){
                       callback && callback(res.result);
                    } else{
                       var msg = res.error ? res.error.text : "";
                       Toast.toast(msg);
                    }
                },
                error: function (res) {
                    var msg = res.error ? res.error.text : "";
                    Toast.toast(msg);
                }
            });
        };
        app.checkLogin(loginEvent, GM.islogin);
    },
    //回帖点灭
    addRuLight: function(pid, callback){
        var loginEvent = function(){
            $.ajax({
                url:constRequest.addRuLight,
                type:"POST",
                data:{
                    "tid": GM.tid,
                    "fid": GM.fid,
                    "pid": pid,
                    "client": GM.client
                },
                dataType:"json",
                success: function(res){
                    if(res && res.status === 200){
                       callback && callback(res.result);
                    } else{
                       var msg = res.error ? res.error.text : "";
                       Toast.toast(msg);
                    }
                },
                error: function (res) {
                    var msg = res.error ? res.error.text : "";
                    Toast.toast(msg);
                }
            });
        };
        if(GM.islogin){
            //如果不存在点灭
            if(!StoreInstance.hasUnLight()){
              Toast.confirm({
                title:"确认要灭了该回帖？",
                content:"仅本次操作有提示，请谨慎使用灭了功能，只可对低质量、无意义、不友善内容点灭，否则可能被视作恶意点灭并受到相应惩罚。",
                submitHandler: function(){
                   loginEvent();
                }
              });
              //弹出一次，不再提示用户.
              StoreInstance.markUnLight();
            } else{
              loginEvent();
            }
        } else{
            app.checkLogin(loginEvent);
        }
    },
    changeRecommendStatus: function(status, callback, errCallback){
        var loginEvent = function(){
            $.ajax({
                url: constRequest.changeRecommendStatus,
                type: "POST",
                data:{
                    tid: GM.tid,
                    client: GM.client,
                    status: status
                },
                dataType:"json",
                success: function(res){
                    var msg = "";
                    if(res.status == 200){
                        msg = status === 1 ? "隐藏推荐成功":"取消隐藏推荐成功";
                        Toast.toast(msg);
                        callback && callback();
                    } else{
                        msg = res.error ? res.error.text : "";
                        Toast.toast(msg);
                        errCallback && errCallback();
                    }
                }
            });
        }
        app.checkLogin(loginEvent, GM.islogin);
    },
    //拉取最新的回复
    getLastPost:function(callback){
        var self = this;
        $.ajax({
            url: constRequest.getLastPage,
            type: "GET",
            data:{
                "tid": GM.tid,
                "client": GM.client
            },
            dataType:"json",
            success: function(res){
                if(res && res.status === 200
                       && res.result && res.result.last_pid
                       && res.result.last_pid != self.lastPid
                ){
                   dace.send("newreplynew");
                   self.totalPage = parseInt(res.result.all_page, 10);
                   callback(res.result.last_pid);
                } else{
                   dace.send("newreplynull");
                   Toast.toast("暂时没有新回复哦~");
                }
            }
        });
    },
    //更新页码
    updatePage: function(page, status){
        this.page = page;
        location.hash = "pn=" + page;

        var isLast = page >= this.totalPage;
        this.refresher && this.refresher.update(isLast);
        if(!GM.isOwner && isLast && this.totalPage >= 1 && this.lastPostCount > 0){
            this.loadMoreReplyBtn.show();
        } else{
            this.loadMoreReplyBtn.hide();
        }
        app.send("hupu.ui.updatebbspager", {
            page: page,
            total: this.totalPage,
            changePage: status
        });
    },
    //页面滚动到指定楼层
    findFloor: function(pid){
       var target = this.replyContainer.find("dl[data-pid='"+ pid +"']");
       if(!target.size() && GM.last){
            GM.last = false;
            target = this.replyContainer.find("dl").last();
       }
       if(target.size()){
           target[0].scrollIntoView();
       }
    },
    //标题置顶显示、lazyload
    titleFixed: function() {
        if(this.titleFixedStatus) return
        this.titleFixedStatus = true;

        var self = this;
        var pics = $("body").find("img.lazy");
        //有图模式下执行（wify）
        if(!GM.nopic) {
            pics.each(function(idx,img) {
                self.imgsCounts(this);
            })
        }
        //$(window).on("onscroll load scroll", function() {
        $(window).on("touchmove scroll", function() {

            var detailContent = $(".detail-content").height(),
                brightReply = $(".bright-reply").height();
            if(!detailContent){
                detailContent = 0;
            }
            if(!brightReply){
                brightReply = 0;
            }
            self.lazyLoadInterval = setTimeout(function(){
                clearTimeout(self.lazyLoadInterval);
                if(!GM.nopic) {
                   self.lazyload($("body").find("img.lazy"));
                }
            }, 200);
           if($(window).scrollTop() >= detailContent && $(window).scrollTop() < detailContent + brightReply-36) {
                $(".title").removeClass("fixed");
                $(".bright-reply .title").eq(0).addClass("fixed");
                return;
            }
            else{
                $(".title").removeClass("fixed");
                return;
            }
        });
    },
    lazyload: function(pics) {
        var self = this;
        var winHeight = $(window).height();
        pics.each(function(idx, img){
            var $img = $(img);
            var lazyTop = $img.offset().top;
            var yWidth = $img.attr("data-w");
            if(img.getAttribute("data-src")){
                if (lazyTop < ($(window).scrollTop() + (3 * winHeight))) {
                    $img.attr("src", $img.attr("data-src"));
                    //$img.removeClass("lazy");删除会影响imgCount图片计算
                    $img.removeAttr("data-src");
                }
                //服务端没有传data-w data-h 时
                 if(!yWidth && img.getAttribute("data-gif")) {
                    //self.imgsCounts(img);
                    $img.on("load", function() {
                        var iHeight = $img.height();
                        var iWidth = $img.width() || 0;
                        if($img.size() && img.getAttribute("data-gif")) {
                            $img.css({
                                "width": iWidth,
                                "height": iHeight
                            });
                            $img.parents(".lazy-gif").css({
                                "width": iWidth,
                                "height": iHeight
                            });
                        }else{
                            $img.css({
                                "width": "auto !important",
                                "height": "auto !important"
                            });
                        }
                    });
                }
            }
        })
    },
    imgsCounts: function(gif) {
        var $gif = $(gif);
        var iHeight = $gif.height();
        var iWidth = $gif.width() || 0;
        var yWidth = $gif.attr("data-w");
        var yHeight = $gif.attr("data-h");
        if(yWidth) {
            if($gif.size() && gif.getAttribute("data-gif")) {
                if(yWidth > iWidth) {
                    iHeight = yHeight * iWidth / yWidth;
                }else{
                    iWidth = yWidth + "px";
                    iHeight = yHeight + "px";
                };
                $gif.css({
                    "width": iWidth,
                    "height": iHeight
                });
                $gif.parents(".lazy-gif").css({
                    "width": iWidth,
                    "height": iHeight
                });
            }else{
                //主贴
                if($gif.closest(".J-article-content").size() && yWidth > 0) {
                    var contentWidth = document.body.clientWidth;
                    //判断图片大小是否超出设备宽度-20
                    if(yWidth > contentWidth-20 ) {
                        var iWidth = contentWidth-20,
                            iHeight = iWidth * yHeight / yWidth;
                        $gif.css({"width": iWidth, "height": iHeight});
                    }else{
                        $gif.css({"width": yWidth+"px", "height": yHeight+"px"});
                    }
                }
                if($gif.closest(".short-quote-content").size() && yWidth > 0) {
                    //引用内容中的图片部分
                    var contentWidth = $(".short-quote-content").width();
                    //判断图片大小是否超出contentWidth宽度
                    if(yWidth > contentWidth ) {
                        var iWidth = contentWidth-16,
                            iHeight = iWidth * yHeight / yWidth;
                        $gif.css({"width": iWidth, "height": iHeight});
                    }else{
                        $gif.css({"width": yWidth+"px", "height": yHeight+"px"});
                    }
                }
                if($gif.closest(".J_contentParent").size() && yWidth > 0) {
                    var contentWidth = $(".J_contentParent").width();
                    //判断图片大小是否超出设备contentWidth宽度
                    if(yWidth > contentWidth ) {
                        var iWidth = contentWidth,
                            iHeight = iWidth * yHeight / yWidth;
                        $gif.css({"width": iWidth, "height": iHeight});
                    }else{
                        $gif.css({"width": yWidth+"px", "height": yHeight+"px"});
                    }
                }
            }
        }

        this.lazyload($("body").find("img.lazy"));
    },
    //回帖图片超出容器宽高(以前img没有宽高才会加的p标签，后期优化的时候可以去掉p标签)
    huitieImg:function(img) {
        var $img = $(img);
        var $parent = $img.parents("p");
        var pHeight = $parent.height();
        var pWidth = $parent.width() || 0;
        if($img.closest(".short-quote-content").size() && pWidth > 0) {
            //引用内容中的图片部分
            var contentWidth = $(".short-quote-content").width();
            //判断图片大小是否超出contentWidth宽度
            if(pWidth > contentWidth ) {
                var cwidth = contentWidth-16,
                    cheight = cwidth * pHeight / pWidth;
                $parent.css({"width": cwidth, "height": cheight});
            }
        }
        //主贴
        if($img.closest(".J-article-content").size() && pWidth > 0) {
            var contentWidth = document.body.clientWidth;
            //判断图片大小是否超出设备宽度-20
            if(pWidth > contentWidth-20 ) {
                var cwidth = contentWidth-20,
                    cheight = cwidth * pHeight / pWidth;
                $parent.css({"width": cwidth, "height": cheight});
            }
        }
        if($img.closest(".J_contentParent").size() && pWidth > 0) {
            var contentWidth = $(".J_contentParent").width();
            //判断图片大小是否超出设备宽度-20
            if(pWidth > contentWidth ) {
                var cwidth = contentWidth,
                    cheight = cwidth * pHeight / pWidth;
                $parent.css({"width": cwidth, "height": cheight});
            }
        }
    },
    //检测浏览器是否支持webp
    check_webp_feature: function(feature, callback) {
        var kTestImages = {
            lossy: "UklGRiIAAABXRUJQVlA4IBYAAAAwAQCdASoBAAEADsD+JaQAA3AAAAAA",
            lossless: "UklGRhoAAABXRUJQVlA4TA0AAAAvAAAAEAcQERGIiP4HAA==",
            alpha: "UklGRkoAAABXRUJQVlA4WAoAAAAQAAAAAAAAAAAAQUxQSAwAAAARBxAR/Q9ERP8DAABWUDggGAAAABQBAJ0BKgEAAQAAAP4AAA3AAP7mtQAAAA==",
            animation: "UklGRlIAAABXRUJQVlA4WAoAAAASAAAAAAAAAAAAQU5JTQYAAAD/////AABBTk1GJgAAAAAAAAAAAAAAAAAAAGQAAABWUDhMDQAAAC8AAAAQBxAREYiI/gcA"
        };
        var img = new Image();
        img.onload = function () {
            var result = (img.width > 0) && (img.height > 0);
            callback(feature, result);
        };
        img.onerror = function () {
            callback(feature, false);
        };
        img.src = "data:image/webp;base64," + kTestImages[feature];

    },
    bindEvent: function(){
        var self = this,
            _last = null,
            _current = null,
            _pid = null,
            _uid = null,
            _username = "",
            _floor = "",
            _content = "",
            _tid = GM.tid;
        // 全部回复事件
        this.allReplyContainer.delegate(".reply-list", "click", function(e){
            //ios只能使用a链接的默认行为
            if(!app.isIOS){
                e.stopPropagation();
                e.preventDefault();
            }
            var target = e.target;
            var currentTarget = $(target);
            var tagName = target.tagName.toLowerCase();
            //评论展开收起
            if(tagName === 'a' && currentTarget.hasClass("J_buttonOpenAll")){
                var parent = currentTarget.parents(".reply-quote-content");
                parent.find(".J_shortContent").hide();
                parent.find(".J_allContent").show();
                currentTarget.hide();
                return;
            }

            if((tagName === 'a' || target.parentNode.tagName.toLowerCase() === "a")){
                setTimeout(function(){
                     popupInstance.hide();
                }, 10);
                if(!app.isIOS){
                    var href = currentTarget.attr("href") || $(target.parentNode).attr("href");
                    location.href = href;
                    return;
                }
            }
            if(tagName === 'img'){
                if(currentTarget.hasClass("J-user-avatar-img") || currentTarget.hasClass("emoji")){
                    return;
                }
                //点击gif图的时候计算图片大小，防止gif角标错位
                if(target.getAttribute("data-gif") && target.getAttribute("data-src")) {
                    var realSrc = target.getAttribute("data-src");
                    $(currentTarget).on("load", function() {
                      self.imgsCounts(currentTarget);
                    });
                    target.src = realSrc;
                }
                if(target.getAttribute("data-src")){
                    var realSrc = target.getAttribute("data-src");
                    target.src = realSrc;
                    target.removeAttribute("data-src");
                } else{
                    if(!target.getAttribute("data-gif")){
                        var imgs = currentTarget.parents(".reply-content").find("img");
                        Images.createAlbum(target, imgs);
                    } else{
                        Images.handlerClickGif(target, GM.nopic);
                    }
                }
                return;
            }

            var touch = e.touches ? e.touches[0] : e;
            var top = Number(touch.pageY);
            _current = $(e.currentTarget);

            if(_current.hasClass("reply-active")){
                _current.removeClass("reply-active");
            } else{
                if(_last !== null){
                    _last.removeClass("reply-active");
                }
                _last = _current;
                _current.addClass("reply-active");
                _uid = _current.data("uid");
                _pid = _current.data("pid");
                _username = _current.data("username");
                _floor = _current.data("floor");
                _content = _current.find(".J_contentParent").text().trim();
                _content = Tool.cutText(_content);
            }
            dace.send("replyOperation");

            //评论赞赏列表
            if(currentTarget.hasClass("praise-reply")){
                 if(_current && _current.hasClass("reply-active")){
                    _current.removeClass("reply-active");
                 }
                app.send("hupu.ui.admirelist", {
                    type : "bbsreply",
                    typeid : _tid,
                    extra: {
                        fid : GM.fid,
                        pid : _pid,
                        uid : _uid,
                        nickname: _username,
                        content: _content.substr(0, 40)
                    }
                });
                return;
            }

            popupInstance.update(top, e.currentTarget);
        });

        // 帖子推荐事件
        this.pageContainer.delegate(".ico-recommend", eventName, function(e){
            var target = e.currentTarget;
            dace.send("post_rec");
            self.addRecommend(function(count){
                Toast.toast("点赞成功");
                target.className = "ico-recommended";
                self.pageContainer.find(".J-recommend-count").text(count);
            });
        });
        // 帖子已推荐提示
        this.pageContainer.delegate(".ico-recommended", eventName, function(e){
            dace.send("post_recalready");
            Toast.toast("你已经赞过该帖子啦");
        });

        // 转水提示
        this.pageContainer.find(".tips").on("click", function(e){
            Toast.alert({
                "content": "为避免版面混乱 同一类型主题帖会合并到最早的同类型主题帖中，或转水处理。",
                "submitText": "关闭"
            })
        });

        /**
         * 版务操作
         * 0 取消， 1为撤下推荐，-1为推荐
         */
        this.pageContainer.find(".J-bbsrecommend-manage").on("change", function(e){
            var $select = $(this);
            var type = +($select.val()) || 0;
            switch(type){
                case 1:
                    self.changeRecommendStatus(1, function(){
                        var oldNode = $select.find("option[value='1']").get(0);
                        var newNode = document.createElement("option");
                        newNode.value = -1;
                        newNode.innerHTML = "取消隐藏推荐";
                        Tool.replaceNode(oldNode, newNode);
                        $select.val(0);
                    }, function(){
                        $select.val(0);
                    });
                    break;
                case -1:
                    self.changeRecommendStatus(-1, function(){
                        var oldNode = $select.find("option[value='-1']").get(0);
                        var newNode = document.createElement("option");
                        newNode.value = 1;
                        newNode.innerHTML = "隐藏推荐";
                        Tool.replaceNode(oldNode, newNode);
                        $select.val(0);
                    }, function(){
                        $select.val(0);
                    });
                    break;
            }
        });

        //帖子回复
        popupInstance.on("reply", function(){
            var loginEvent = function(){
                if(_tid && _pid && _uid){
                    app.send("hupu.ui.bbsreply", {
                        open: true,
                        extra:{
                            tid: _tid,
                            pid: _pid,
                            uid: _uid,
                            username : _username,
                            floor: _floor,
                            content: _content.substr(0, 40)
                        }
                    });
                }
            }
            app.checkLogin(loginEvent, GM.islogin);
        });

        //回帖赞赏回调
        $(document).on("bbs:replyzan", function(e, data){
            var tpl = _.template(['<div class="praise-reply J-praise-<@=pid@>" >',
                            '已有<span class="praise-person">1</span>个JRs赞赏了<span class="praise-count"><@=count@></span>虎扑币 &gt;',
                        '</div>'].join(''));
            var $praiseCon = $(".J-praise-" + data.pid);
            if($praiseCon.size()){
               var userCount = +($praiseCon.find(".praise-person").text()) + 1;
               var goldCount = parseInt($praiseCon.find(".praise-count").text()) + parseInt(data.amount);
               $praiseCon.find(".praise-person").text(userCount);
               $praiseCon.find(".praise-count").text(goldCount);
            } else{
               $("dl[data-pid='"+ data.pid +"']").find(".reply-content").append(tpl({pid: data.pid, count: data.amount}));
            }
        });

        //回复赞赏
        popupInstance.on("zan", function(){
            var loginEvent = function(){
                if(_current && _current.hasClass("reply-active")){
                    _current.removeClass("reply-active");
                }
                app.send("hupu.ui.admire", {
                    type: "bbsreply",
                    typeid : _tid,
                    extra:{
                        "fid": GM.fid,
                        "pid": _pid,
                        "uid": _uid,
                        "nickname": _username,
                        "content": _content.substr(0, 40)
                    }
                });
            }
            app.checkLogin(loginEvent, GM.islogin);
        });

        //回帖内容举报
        popupInstance.on("report", function(){
            var loginEvent = function(){
                if(_tid && _pid){
                    app.send("hupu.ui.report", {
                        open: true,
                        extra:{
                            tid: _tid,
                            pid: _pid,
                            fid: GM.fid
                        }
                    });
                }
            }
            app.checkLogin(loginEvent, GM.islogin);
        });

        //回帖点亮
        popupInstance.on("light", function(){
            self.addLight(_pid, function(count){
                //接口异常返回null
                if(!count){
                    count = _current.find(".reply-light").text().match(/\d+/);
                    count = count && count.length == 1 ? (parseInt(count[0], 10) + 1) : 1;
                }
                _current.find(".reply-light").text("亮了("+ count +")");
                Toast.count(_current.find(".reply-light"), "+1", "right");
                Toast.toast("点亮成功");
            });
        });

        //回帖点灭
        popupInstance.on("rulight", function(){
            self.addRuLight(_pid, function(count){
                //接口异常返回null
                if(!count){
                    count = _current.find(".reply-light").text().match(/\d+/);
                    count = count && count.length == 1 ? (parseInt(count[0], 10) + 1) : 1;
                }
                _current.find(".reply-light").text("亮了("+ count +")");
                Toast.count(_current.find(".reply-light"), "-1", "right");
                Toast.toast("已点灭");
            });
        });

        $(window).on("hashchange", function(){
            var page = self.getPage();
            if(page != self.page){
                self.loadReply(page, 2);
            }
        });

        //加载更多回复
        this.loadMoreReplyBtn.on("click", function(e){
            self.getLastPost(function(pid){
                if(pid != self.lastPid){
                    app.send("hupu.ui.updatepagestatus");
                    if(self.lastPostCount < 20){
                        var oldPid = self.lastPid;
                        self.loadReply(self.page,  3, function() {
                            self.findFloor(oldPid);
                        });
                    } else{
                        self.loadReply(self.page + 1, 4, function() {
                            self.findFloor(self.lastPid);
                            self.lastPid = pid;
                        });
                    }
                }
            });
        });

        //返回页面最顶部
        app.register("hupu.ui.backtop", function(){
            window.scrollTo(0, 0);
        });

        //最后一页回复，刷新页面
        app.register("hupu.ui.refresh", function(){
            GM.last = true;
            self.loadReply(self.totalPage, 4, function(){
                self.findFloor("");
            });
        });

        //注册事件，等Native调起, for android.
        app.register("hupu.ui.bbspageupdate", function(){
            app.send("hupu.ui.updatebbspager", {
                page: self.page,
                total: self.totalPage
            });
        });
    }
}

module.exports = replyPage;
