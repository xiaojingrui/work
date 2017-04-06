(function(){
    // function initBridge(callback) {
    //     if(window.HupuBridge){
    //         callback();
    //     }else{
    //         document.addEventListener("hupuBridgeReady", function(){
    //             callback();
    //         });
    //     }
    // }
    //
    // initBridge(function() {
    //     HupuBridge.send("hupu.ui.share", {
    //             open: false
    //         }, function() {}
    //     );
    // });

    var _ = require('underscore'),
        refresh = require("common:widget/ui-refresh/ui-refresh.js");

    var Message = {
        init: function() {
            this.render();
            this.bind();
        },

        render: function(){
            this.wrap = $('#J_content');
            this.html = $("#J-tpl").html() || "";
            this.tplRender = _.template(this.html);
            this.iH = $("#J-height").height();
            this.isOver = false;
            this.isLoad = GM.hasNextPage ? true : false;

            this.noResult = $(".no-result");
            this.noResult.show();
            this.noResult.css("height", this.iH * 0.9);
        },

        bind: function(){
            var self = this;
            self.initScroll();
        },

        getMorePost: function(pageStr, callback) {
            var self = this;
            var url = "/" + GM.projectId + "/" + GM.version + "/message/list";
            var html = "";

            if(location.href.indexOf("127.0.0.1")!=-1 || location.href.indexOf("localhost")!=-1){
                url += self.wrap.data("type");
            }

            self.isOver = true;

            $.ajax({
                url: url,
                type: "GET",
                dataType: "json",
                data: {
                    pageStr: pageStr,
                    msg_type: self.wrap.data("type"),
                    client: GM.client
                },
                success: function(data){
                    if(data.status == 200) {
                        GM.hasNextPage = data.result.hasNextPage;
                        GM.pageStr = data.result.pageStr;
                        self.isOver = false;
                        html = self.tplRender({
							datas: data.result.data
						});
                        self.wrap.append(html);
                        if(!GM.hasNextPage) {
                            if(self.wrap.data("type") == "2"){
                                self.wrap.append("<div class='history'>没有更多了</div>");
                            }else{
                                self.wrap.append("<div class='item-tip nomore'>没有更多了</div>");
                            }
                            callback && callback("finish");
                        }else{
                            callback && callback();
                        }
                    }
                },
                error: function(){
                    self.isOver = false;
                    callback && callback("finish");
                }
            });
        },
        initScroll: function() {
            var self = this;

    		refresher = refresh({
    			contentEl: '#J_content',
    			isRefresh: true,
    			isLoadingMore: self.isLoad,
    			loadingMoreCallback: function(callback) {
                    if (!self.isOver && GM.hasNextPage) {
                        self.getMorePost(GM.pageStr, callback);
    				} else {
    					callback("finish");
    				}
    			},
                refreshCallback: function(callback) {
                    location.href = location.href;
                }
    		});
        }
    }
    Message.init();
})();
