/**
 * @name 警告框
 * @author yuhongfei@hupu.com
 * @description 警告框
 */
var Warn = function (){};
Warn.prototype = {
    init : function(container) {
        var html = [
            '<div class="warn-main">',
                '<h3>加载失败</h3>',
                '<p><span class="icon-reload"></span>点击屏幕重新加载</p>',
            '</div>'
        ].join("");
        this.container = $("<div class='detail-warnnig'></div>").html(html);
        $(container || "body").append(this.container);
        this.bindEvent();
    },
    setIndex: function(index){
        this.container.css("z-index", index);
    },
    bindEvent: function(){
        var self = this;
        this.container.click(function(e){
            self.hide();
            self.rollCallback && self.rollCallback();
        });
    },
    //实现重写
    rollCallback: function(){

    },
    show: function(){
        this.container.show();
    },
    hide: function(){
        this.container.hide();
    }
};

module.exports = Warn;
