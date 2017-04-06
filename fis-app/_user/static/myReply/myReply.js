(function() {
    function initBridge(callback) {
        if(window.HupuBridge){
            callback();
        }else{
            document.addEventListener("hupuBridgeReady", function(){
                callback();
            });
        }
    }

    initBridge(function() {
        HupuBridge.send("hupu.ui.share", {
                open: false
            }, function() {}
        );
    });
    var _ = require('underscore'),
        refresh = require("common:widget/ui-refresh/ui-refresh.js"),
        targetJump = require('common:widget/target-jump/target-jump.js');

    var MoreReply = {
        init: function() {
            this.wrap = $('#J_content');
            this.flag = false;
            this.initLoad();
            this.imgCount();
        },
        initLoad: function() {
            var self = this;
            this.loadToEnough(GM.nextPage);
        },
        loadToEnough: function(nextPage) {
            if(this.wrap.find('li').length < 10 && nextPage){
                this.getmoreReply();
                this.flag = true;
            }else{
                this.scrollBind();
                this.flag = false;
            }
        },
        getmoreReply: function(callback) {
            var url = "/" + GM.projectId +"/"+ GM.version + "/user/getUserPosts?" + "puid="+ GM.puid + "&client=" + GM.client,
                self = this;

            var success = function(data) {
                if(data.status == 200) {
                    
                    $('#J_content').append(_.template( $('#J-reply-tpl').html(),{datas: data.result.list} ));
                    GM.page ++;

                    var hasNextPage = data.result.nextPage;

                    if(hasNextPage) {
                        if(self.flag) {
                            self.loadToEnough(hasNextPage);
                        }
                        callback && callback();

                    }else{
                        $('.my-reply-wrap').append('<div class="has-more-reply"><p>由于权限限制，部分回帖可能被隐藏</p><p>没有更多</p></div>');
                        callback('finish');
                    }
                }
                self.imgCount();
            };
            
            var error = function() {
                callback && callback("finish");
            }
            
            this.ajax(url, success, error);

        },
        ajax: function(url, success, error){
            $.ajax({
                type: 'GET',
                url: url,
                data:{
                    page: GM.page
                },
                dataType: 'json',
                timeout: 3000,
                success: success,
                error: error
            });
        },
        //计算正文图片超出容器宽高
        imgCount:function() {
            var clientWidth = document.body.clientWidth;
            var lazy = $(".lazy");
            for(var i=0;i<lazy.length;i++) {
                var pHeight = lazy.eq(i).parent("p").height();
                var pWidth = lazy.eq(i).parent("p").width();
                //判断图片大小是否超出设备宽度-20
                if(pWidth) {
                   if(pWidth > clientWidth-20 ) {
                        lazy.eq(i).parent("p").width(clientWidth-20);
                        lazy.eq(i).parent("p").height((lazy.eq(i).parent("p").width()*pHeight)/pWidth);
                    }
                    //计算后p的高度小于img高度后给img添加height:100%
                    if(lazy.eq(i).parent("p").height() < lazy.eq(i).height()){
                        lazy.eq(i).css("height","100%");
                    }
                }
                //判断img高度是否高于p标签
                if(lazy.eq(i).height() > pHeight && pHeight) {
                    lazy.eq(i).css("height","100%");
                }
            }
        },
        scrollBind: function() {
            var self = this,
                firstMore = (GM.nextPage ? true: false);

            refresh({
                contentEl: '#J_content',
                isRefresh: false,
                // 向下
                loadingMoreCallback: function(complete) {
                    self.getmoreReply(complete);
                },
                isLoadingMore: firstMore
            });
        }
    };

    

    function linkPrevent() {
        $('#J_content').delegate('.J_contentParent a', 'click', function(e) {
            e.preventDefault();
        });
        $('#J_content').delegate('.J_buttonOpenAll', 'click', function(e) {
            e.preventDefault();
            var currentTarget = $(e.target);
            var parent = currentTarget.parents(".reply-quote-content");
            parent.find(".J_shortContent").hide();
            parent.find(".J_allContent").show();
            currentTarget.hide();
        });
    }

    $(document).ready(function () {
        MoreReply.init();

        linkPrevent();
        
        FastClick.attach(document.body);

        var hasTouch = 'ontouchend' in window;

        $('body').on(hasTouch ? 'click' : 'mousedown', function (e) {
            // 列表跳转链接
            
            targetJump.init(e);
        });

    });
})()