(function(){
    var _ = require('underscore'),
        refresh = require("common:widget/ui-refresh/ui-refresh.js");

    var Message = {
        init: function() {
            this.render();
            this.bind();
        },

        render: function(){
            this.wrap = $('#J_content');
            this.iH = $(window).height();
            this.tplRender = _.template($("#J-tpl").html());
            this.isOver = false;
            this.isLoad = GM.hasNextPage ? true : false;

            this.api = [
                "/my/remind/at",
                "/my/remind/reply",
                "/my/remind/light"
            ];

            this.noResult = $(".no-result");
            this.noResult.css("height", this.iH - 93);
        },

        bind: function(){
            var self = this;

            self.initScroll();

            $(".no-result").show();

            setTimeout(function(){
                $(".tab").find("a").eq(self.wrap.data("type")-1).find(".remind").animate({
                    "opacity": "0"
                }, 300);
            }, 1000);
        },

        getMorePost: function(id, time, callback) {
            var self = this;

            self.isOver = true;

            $.ajax({
                url: self.api[self.wrap.data("type")-1],
                type: "GET",
                dataType: "json",
                data: {
                    id: id,
                    time: time
                },
                success: function(data){
                    if(data.status == 200) {
                        var html = self.tplRender({
							datas: data.data.list
						});
                        self.wrap.append(html);
                        GM.hasNextPage = data.data.nextPage;
                        GM.id = data.data.list[data.data.list.length-1].id;
                        GM.time = data.data.list[data.data.list.length-1].update_time;
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
                        self.isOver = false;
                    }
                },
                error: function(){
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
    					self.getMorePost(GM.id, GM.time, callback);
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
