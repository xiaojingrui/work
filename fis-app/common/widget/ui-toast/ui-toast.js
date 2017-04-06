/**
 * @file 全部黑色提示层
 * @author yuhongfei@hupu.com
 * @date 2015-10-23
 **/
var EventEmitter = require("common:widget/ui-events/ui-events.js");
var eventInstance = new EventEmitter();

var timer = null;
var Toast = {
    toast: function(msg) {
        if (!msg || !msg.length) return;

        var $toast = this._$toast;

        if (!$toast) {
            var tpl = '<div class="m-toast" id="J_toast"><p></p></div>';
            $("body").append(tpl);
            $toast = this._$toast = $("#J_toast");
        }
        timer = null;
        clearTimeout(timer);

        $toast
            .removeClass('m-toast-hide')
            .show()
            .find("p")
            .html(msg);


        // 获取位标
        function getPosition() {
            var win = $(window),
                getViewWidth = win.width(),
                getViewHeight = win.height(),
                getSrollTop = win.scrollTop(),
                getSrollLeft = win.scrollLeft(),
                width = Math.max($toast.width(), 100),
                top = getSrollTop + getViewHeight / 3,
                left = getSrollLeft + (getViewWidth - width) / 2;


            return {
                top: top,
                left: left
            }
        }

        var getPos = getPosition();

        $toast
            .css({
                top: getPos.top,
                left: getPos.left
            });

        timer = setTimeout(function() {
            clearTimeout(timer);
            $toast.addClass('m-toast-hide');
            setTimeout(function() {
                $toast.hide();
            }, 400);
        }, 1130);
    },
    /**
     * 提示数字 +1
     * @param elem
     * @param text
     */
    count: function(elem, text, pos) {

        var $elem = $(elem),
            offset = {
                top: Math.floor($elem.offset().top - 15)
            };
        if(pos && pos == "right"){
            offset.right = 30;
        } else{
            offset.left = Math.floor($elem.offset().left + 30);
        }

        var $tip = $("#J_tipCount");

        if (!$tip.length) {
            var tpl = '<div id="J_tipCount" class="m-tip-count">'+ text +'</div>';
            $("body").append(tpl);
            $tip = $("#J_tipCount");
        }else{
            $tip.html(text);
        }

        $tip
            .show()
            .css(offset)
            .addClass('transform-tip-count')
            .cssEnd(function() {
                $(this)
                    .removeClass('transform-tip-count')
                    .hide();
            });

    },
    //更新组件
    update: function($instance, options, type){
        //更新ui
        $instance.html(options.html);

        //更新取消事件
        if(options.cancelHandler){
            var cancelEvt = type + "_cancel";
            eventInstance.removeAllListeners(cancelEvt);
            eventInstance.on(cancelEvt, options.cancelHandler);
        }

        //更新确认事件
        if(options.submitHandler){
            var submitEvt = type + "_submit";
            eventInstance.removeAllListeners(submitEvt);
            eventInstance.on(submitEvt, options.submitHandler);
        }
    },
    alert: function(options){
        var type = "alert";
        var config = $.extend({
          title: "",
          content: "",
          align: "center",
          submitHandler: function(){},
          submitText: "确认"
        }, options);
        config.html = [
          '<div class="toast-player">',
            '<div class="content text-', config.align ,'">',
            (config.title ? ('<h2>'+ config.title +'</h2>') : ''),
            '<p>', config.content ,'</p></div>',
            '<div class="btn-box clearfix">',
              '<span class="submit">',config.submitText,'</span>',
            '</div>',
          '</div>'
        ].join("");

        if(!this.$alert){
            this.$alert = $("<div class='toast-mask'></div>").html(config.html);
            $("body").append(this.$alert);
            var self = this;
            var hideName   = type + "_hide",
                submitName = type + "_submit";

            var alertHide = function(){
              self.$alert.hide();
            }
            eventInstance.on(hideName, alertHide);
            eventInstance.on(submitName, config.submitHandler);

            this.$alert.on("click", function(e){
              var target = e.target;
              var tagName = target.tagName.toLowerCase();
              var currentTarget = $(target);
              if(currentTarget.hasClass("submit")){
                eventInstance.emit(hideName);
                eventInstance.emit(submitName);
                return;
              }

              if(currentTarget.hasClass("content")
                || tagName === "h2"
                || tagName === "p"
              ){
                return;
              }
              eventInstance.emit(hideName);
            });
          } else{
             if(options){
                 this.update(this.$alert, config, type);
             }
             this.$alert.show();
          }
    },
    confirm: function(options){
        var type = "confirm";
        var config = $.extend({
          title: "",
          content: "",
          align: "center",
          submitHandler: function(){},
          submitText: "确认",
          cancelText: "取消",
          cancelHandler: function(){}
        }, options);
        config.html = [
          '<div class="toast-player">',
            '<div class="content"><h2>', config.title ,'</h2><p>', config.content ,'</p></div>',
            '<div class="btn-box clearfix">',
              '<span class="cancel">',config.cancelText,'</span>',
              '<span class="submit">',config.submitText,'</span>',
            '</div>',
          '</div>'
        ].join("");

      if(!this.$confirm){
          this.$confirm = $("<div class='toast-mask'></div>").html(config.html);
          $("body").append(this.$confirm);

          var self = this;
          var confirmHide = function(){
            self.$confirm.hide();
          }
          var hideName   = type + "_hide",
              cancelName = type + "_cancel",
              submitName = type + "_submit";
          eventInstance.on(hideName, confirmHide);
          eventInstance.on(cancelName, config.cancelHandler);
          eventInstance.on(submitName, config.submitHandler);

          this.$confirm.on("click", function(e){
            var target = e.target;
            var tagName = target.tagName.toLowerCase();
            var currentTarget = $(target);
            if(currentTarget.hasClass("cancel")){
              eventInstance.emit(hideName);
              eventInstance.emit(cancelName);
              return;
            }
            if(currentTarget.hasClass("submit")){
                eventInstance.emit(hideName);
                eventInstance.emit(submitName);
              return;
            }

            if(currentTarget.hasClass("content")
              || tagName === "h2"
              || tagName === "p"
            ){
              return;
            }
            eventInstance.emit(hideName);
          });
        } else{
           if(options){
                this.update(this.$confirm, config, type);
           }
           this.$confirm.show();
        }
    }
}

/**
 * 监听CSS3动画执行结束
 * @param callback
 * @returns {$.fn}
 */
$.fn.cssEnd = function ( callback ){
    var EventAnimateEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
    this.one(EventAnimateEnd , callback);
    return this;
};

module.exports = Toast;
