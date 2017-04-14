/**
 * pager.share
 */
!function() {
    var common = pager.common;
    pager.share = {
        name : "share",
        start: function() {
            var self = this;

            if(!this.init){
                this.init = true;
                this.container = $('.share-page');
                this.shareTpl = $("#share-tpl").html();

                var url = encodeURIComponent(location.href);
                var title = encodeURIComponent(pager.title || "2015虎扑征途");
                var pics = encodeURIComponent("http://b3.hoopchina.com.cn/touch/resource/events/2015journey/avatar.png");
                var shareWeibo = "http://service.weibo.com/share/share.php?url="+url+"&title="+title+"&pic="+pics+"&appkey=2175967801&ralateUid=&searchPic=true";
                var shareQzone = "http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url="+url+"&title="+title+"&pics="+pics+"&summary=&site=";

                var html = _.template(this.shareTpl)({
                    host : pager.host,
                    text: pager.showData.footer.text,
                    linkShareWeibo : shareWeibo,
                    linkShareQzone : shareQzone,
                    isWeixin: pager.isWeixin
                });
                this.container.html(html);
                this.bindEvent();
                try{__dace.sendEvent("0003");}catch(e){};

                this.modText = this.container.find(".mod-text");
                this.mineBtn = this.container.find(".mine");
                this.title  = this.container.find(".title");
                this.others  = this.container.find(".others");
            }

            this.showText();
        },
        bindEvent: function(){
            var self = this;
            this.container.delegate(".share", common.eventName, function(){
                self.showShare();
            });

            this.container.delegate(".mine", common.eventName, function(){
                common.showSearch();
            });
        },
        showText: function(){

           this.modText.transition({
                opacity: 1,
                translate: [0,-20],
                skewX: "-15deg",
                delay : 500
            }, 500);

           this.mineBtn.transition({
                opacity: 1,
                translate: [0,-20],
                delay : 1000
            }, 1200);

           this.title.transition({
                opacity: 1,
                translate: [0,-20],
                delay : 1300
            }, 1800);

           this.others.transition({
                opacity: 1,
                translate: [0,-20],
                delay : 1300
            }, 1800);

        },
        showShare: function(){
            if(!this.$shareMask){
                var self = this;
                this.$shareMask = $("<div class='mask'></div>");
                this.$tips = $("<div class='share-tips'></div>");
                $("body").append(this.$shareMask);
                $("body").append(this.$tips);

                this.$shareMask.on(common.eventName, function(e){
                    self.hideShare();
                });
                this.$tips.on(common.eventName, function(e){
                    self.hideShare();
                });
            }
            this.$shareMask.show();
            this.$tips.show();
        },
        hideShare: function(){
            this.$shareMask.hide();
            this.$tips.hide();
        },
        stop: function() {
            this.running = false;
        }
    };
}();