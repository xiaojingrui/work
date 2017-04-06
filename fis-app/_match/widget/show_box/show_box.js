var show_box = {
    init: function(obj, cover) {
        this.obj = $(obj);
        this.cover = $(cover);
        this.iWidth  = $(window).width();
        this.iHeight = $(window).height();
        this.showWrapH();
        this.showBox();
    },
    getHeight: function(){
        var elem = document,
            doc  = elem.documentElement;

        return Math.max(
            elem.body[ "offsetHeight" ], doc[ "offsetHeight" ],
            doc[ "clientHeight" ]
        );
    },
    scrollStop : function(){
        $('html, body').addClass('m-scroll-stop');

        this.cover.on("touchmove.replypopup",function(e){
            e.stopPropagation();
            e.preventDefault();
        });
    },
    //启动滚动条
    scrollStart : function(){
        $('html, body').removeClass('m-scroll-stop');
        this.cover.off('.replypopup');
    },
    showBox: function(){
        var self = this;
        this.obj.show();
        setTimeout(function () {
            self.obj.removeClass('m-hide');
        }, 20);
        this.cover.show();
        this.boxCenter();
        this.scrollStop();
        this.obj.find(".close").on("click", function(){
            self.hideBox();
        });
        this.cover.on("click", function(e){
            self.hideBox();
        });
    },
    hideBox: function() {
        var self = this;
        this.obj.addClass('m-hide');
        this.obj.one('webkitTransitionEnd', function(e) {
            // alert(self.obj.css('opacity'));
            self.obj.hide();
        });
        self.cover.hide();
        self.scrollStart();

    },

    showWrapH: function(){
        //页面高度不够，用css补上. by FHY.
        var winHeight = window.innerHeight;
        var docHeight = document.body.offsetHeight;
        if(docHeight < winHeight){
            var style = document.createElement("style");
            style.innerHTML = "html,body{height:100%;}";
            document.body.appendChild(style);
        }
        this.cover.css("height", this.getHeight());
    },

    boxCenter: function(){
        var self = this;
        var objWidth = this.obj.width();
        var objHeight = this.obj.height();

        if(this.obj.size()==1){
            this.obj.css({
                "left":(self.iWidth-objWidth)/2,
                "top":(self.iHeight-objHeight)/2
            });
        }else{
            this.obj.each(function(){
                $(this).css({
                    "left":(self.iWidth-objWidth)/2,
                    "top":(self.iHeight-objHeight)/2
                });
            });
        }
    }
}

module.exports = show_box;