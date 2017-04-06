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
    //关闭分享按钮
    initBridge(function() {
        HupuBridge.send("hupu.ui.share", {
                open: false
            }, function() {}
        );
    });
    var _ = require('underscore'),
        imageShow = require('common:widget/click-image-show/click-image-show.js'),
        refresh = require("common:widget/ui-refresh/ui-refresh.js"),
        dace = require("common:widget/ui-dace/ui-dace.js"),
        Toast = require("common:widget/ui-toast/ui-toast.js"),
        targetJump = require('common:widget/target-jump/target-jump.js'),
        msgid = GM.msgid,
        firstMore = (GM.nextPage==0 ? false: true);


        $(".reply-inner").delegate(".reply-list","click",function(e) {
            var target = e.target;
            var targetCL = $(target);
            
            var currentTarget = e.currentTarget;
            var currentTargetCL = $(currentTarget);
            var tagName = target.tagName.toLowerCase();
            if(targetCL.hasClass("J-delete-content")) {
                e.stopPropagation();
                e.preventDefault();
                Toast.alert({"content":"抱歉，该评论已被删除"});
                return;
            }
            if(tagName === 'span' && targetCL.parent().hasClass("J-delete-content")) {
                e.stopPropagation();
                e.preventDefault();
                Toast.alert({"content":"抱歉，该评论已被删除"});
                return;
            }
            if($(target.parentNode).hasClass("user-avatar") ){
                e.stopPropagation();
                e.preventDefault();
                var href = $(target.parentNode).attr("href");
                location.href = href;
                return;
            }
            if(currentTargetCL.find(".J-delete-content").size()) {
                e.stopPropagation();
                e.preventDefault();
                Toast.alert({"content":"抱歉，该评论已被删除"})
                return;
            }           
        }) 
    var morePost = {
        init: function() {
            this.wrap = $('#J_content');
            this.flag = false;
            this.initLoad();
        },
        initLoad: function() {
            var self = this;
            this.loadToEnough(firstMore);
        },
        loadToEnough: function(nextPage) {
            //if(this.wrap.find('li').length < 10 && nextPage){
            if(nextPage) {
                this.getMorePost();
                this.flag = true;
            }else{
                //this.scrollBind();
                this.flag = false;
            }
        },
        getMorePost: function(callback) {
            var url = "/" + GM.projectId +"/"+ GM.version + "/message/getList?client=" + GM.client ;

            var success = function(data) {
               
                $(".has-more-reply").hide(); 
                if(data.result){
                    var  tpl = _.template( $('#J_replyListTpl').html());
                    var html = tpl({datas: data.result.data,header:data.result.header} );
                    $('#J_content').append(html);
                    GM.page ++;
                    msgid = data.result.data[data.result.data.length-1].id;
                    // 头像默认替换
                    imageShow.listenImagesReplaceErr($("#J_content").find("img"));
                    //callback && callback(); 
                    var hasNextPage = data.result.hasNextPage;
                    if(hasNextPage) {
                        if(self.flag) {
                            self.loadToEnough(hasNextPage);
                        }
                        callback && callback();
                    }else{
                        $('.my-reply-wrap').append('<div class="has-more-reply-no"><p>没有更多新闻消息了</p></div>'); 
                        callback('finish');
                    }
                }              
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
                    msgid: msgid                   
                },
                dataType: 'json',
                timeout: 3000,
                success: success,
                error: error
            });
        },
        scrollBind: function() {
            refresh({
                contentEl: '#J_content',
                isRefresh: false,
                // 向下
                loadingMoreCallback: function(complete) {
                    $(".has-more-reply").hide(); //当新消息超过20条时隐藏
                    $('.has-more-reply-no').hide();
                    morePost.getMorePost(complete);
                },
                isLoadingMore: firstMore
            });
        }    
    }
    //点击查看更多历史消息
    $(".has-more-reply").on("click",function() {
        morePost.getMorePost();
    });

    var showAllComment = {
        bind : function() {
            $('#J_content')
                .delegate('.J_buttonOpenAll', 'click', function(event) {
                    $(this).parent().siblings('.J_shortContent').hide();
                    $(this).parent().hide();
                    $(this).parent().siblings('.J_allContent').show();
                })
        }
    };
    if(firstMore){
        morePost.scrollBind();
    }
    showAllComment.bind();
    morePost.init();

    // 头像默认替换
    //imageShow.listenImagesReplaceErr($("#J_content").find("img"));
    $(document).ready(function () {        
        var hasTouch = 'ontouchend' in window;
        //FastClick.attach(document.body);
        $('body').on(hasTouch ? 'click' : 'mousedown', function (e) {
            targetJump.init(e);
        });
    });

})()
