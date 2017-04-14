!function(){
    var _ = require('underscore');
    //页面分页
    var pager = require("common:widget/ui/page/page.js");
    var Tips = require('common:widget/ui/tips/tips.js');
    var reply = require('bbs:widget/reply/reply.js');

    var pageScript = {
        init: function(){
            this.pagerCreate();
            reply.init();
            //this.follow();
            this.render();
        },
        render:function() {
            if(HPM.page != 1) {
                $(".detail-content").hide();
            }
        },
        //定位到某楼层
        follow: function(){
            var hash = location.hash;
            var regPid = /&?floor=(\d+)/i;
            if(regPid.test(hash)){
                var match = hash.match(regPid);
                var pid = match.length === 2 ? match[1]:"";
                if(pid && $(".J-reply-"+ pid).size()){
                    $(".J-reply-"+ pid).get(0).scrollIntoView();
                    location.hash = hash.replace(regPid, "");
                }
            }
        },
        //创建分页
        pagerCreate: function(){
            var self = this;
            if(HPM.focus_author) {
                var focusAuthor = "?focus_author=" + HPM.focus_author;
            }else{
                var focusAuthor = "";
            }
            if(HPM.author){
                var puid = "_" + HPM.author;
            }else{
                var puid = "";
            }
            pager({
                isAjax: true,
                container:"#J-page",
                currntPage: HPM.page,
                pageCount: HPM.pageCount,
                urlFormat: "/bbs/" + HPM.tid +puid+"-#{page}.html",
                indexLink: HPM.Url,
                pageChange: function(page){
                    //window.location.reload();
                    if(HPM.author) {
                        var url = "/api/bbs/replies"+"/"+ HPM.tid +"_" + HPM.puid +"-#{page}";
                    }else{
                        var url = "/api/bbs/replies"+"/"+ HPM.tid +"-#{page}";
                    }

                    url = url.replace("#{page}", page);
                    $.ajax({
                        url: url,
                        type: "GET",
                        dataType: 'json',
                        success: function(data) {
                            if(data.data.page != 1) {
                                $(".detail-content").hide();
                                $(".bright-reply").hide();
                                $(".ad-hide").hide();
                                $(".guess-like").hide();
                                $(".hot-news-list").hide();
                                $(".page2-hide").hide();
                            }else{
                                //判断是否为楼主
                                if(HPM.author) {
                                    $(".detail-content").show();
                                    $(".bright-reply").hide();
                                    $(".guess-like").hide();
                                    $(".hot-news-list").hide();
                                    $(".page2-hide").show();
                                }else{
                                    window.location.reload();
                                }
                            }
                            if ( +data.status === 200 ) {
                                var html = _.template( $("#J_more_reply_template").html(), {datas: data.data.replies} );
                                $('#J_reply_container').html( html );
                                document.body.scrollIntoView(true);

                                reply.listBind();
                            } else{
                                Tips(data.msg);
                            }
                        }
                    });
                }
            });
        }
    };

    $(function(){
        pageScript.init();
    });

}();
