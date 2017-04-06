!function(){
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
    var MorePost = {
        init: function() {
            this.wrap = $('#J_content');
            this.flag = false;
            this.initLoad();
        },
        initLoad: function() {
            var self = this;
            this.loadToEnough(GM.nextPage);
        },
        loadToEnough: function(nextPage) {
            if(this.wrap.find('li').length < 10 && nextPage){
                this.getMorePost();
                this.flag = true;
            }else{
                this.scrollBind();
                this.flag = false;
            }
        },
        getMorePost: function(callback) {
            var url = "/" + GM.projectId +"/"+ GM.version + "/user/getUserRecommend?" + "puid="+ GM.puid + "&client=" + GM.client,
                self = this;
            var success = function(data) {
                //if(data.status == 200) {         
                    $('#J_content').append(_.template( $('#J-post-tpl').html(),{datas: data.list} ));
                    GM.page ++;
                    var hasNextPage = data.result.nextPage;
                    if(!hasNextPage) {
                        $('.rec-list').append('<div class="has-more-reply"><p>由于权限限制，部分帖子可能被隐藏</p><p>没有更多</p></div>');
                        callback('finish');
                    }else{
                        if(self.flag) {
                            self.loadToEnough(hasNextPage);
                        }
                        callback && callback();
                    }
               // }

            };

            var error = function(data) {
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
        scrollBind: function() {
            var self = this,
                firstMore = (GM.nextPage ? true: false);

            refresh({
                contentEl: '#J_content',
                isRefresh: false,
                // 向下
                loadingMoreCallback: function(complete) {
                    self.getMorePost(complete);
                },
                isLoadingMore: firstMore
            });
        }
    }

    MorePost.init();

    $(document).ready(function () {        
        var hasTouch = 'ontouchend' in window;
        //FastClick.attach(document.body);
        $('#J_content').on(hasTouch ? 'click' : 'mousedown', function (e) {
            targetJump.init(e);
        });
    });



}()