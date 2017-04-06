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
        targetJump = require('common:widget/target-jump/target-jump.js'),
        ncid = 0,
        firstMore = (GM.nextPage ? true: false);

    ncid = $('.reply-list:last-child').data('ncid');

    var morePost = {
        getMorePost: function(callback) {
            var url = "/" + GM.projectId +"/"+ GM.version + "/news/getUserComment?" + "uid="+ GM.uid + "&client=" + GM.client ;

            var success = function(data) {
                
                $('#J_content').append(_.template( $('#J_replyListTpl').html(),{datas: data.result.data} ));
                ncid = data.result.data[data.result.data.length-1].ncid;
                callback && callback();
                
                var hasNextPage = data.result.hasNextPage;

                if(hasNextPage) {
                    callback();
                }else{
                    callback('finish');
                    $('.news-inner').append('<div class="has-more-reply"><p>没有更多</p></div>');
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
                    ncid: ncid
                },
                dataType: 'json',
                timeout: 30000,
                success: success,
                error: error || function(){}
            });
        }
    }

    refresh({
        contentEl: '#J_content',
        isRefresh: false,
        // 向下
        loadingMoreCallback: function(complete) {
            morePost.getMorePost(complete);
        },
        isLoadingMore: firstMore
    });

    var showAllComment = {
        bind : function() {
            $('#J_content')
                .delegate('.J_buttonOpenAll', 'click', function(event) {
                    $(this).parent().siblings('.J_quoteShortContent').hide();
                    $(this).parent().hide();
                    $(this).parent().siblings('.J_quoteAllContent').show();
                })
        }
    };

    showAllComment.bind();

    $(document).ready(function () {
        var hasTouch = 'ontouchend' in window;
        FastClick.attach(document.body);
        
        $('body').on(hasTouch ? 'click' : 'mousedown', function (e) {
            targetJump.init(e);
        });

    });
})()