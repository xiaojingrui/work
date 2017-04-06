/**
 * @name 弹出层tips
 * @author yuhongfei@hupu.com
 * @class Popup
 */
var Toast = require("common:widget/ui-toast/ui-toast.js");
var dace = require("common:widget/ui-dace/ui-dace.js");

var Popup = function (){
	this.events = {};
	this.target = null;
	this.isShow = false;
    this._btnLength = 0;
}
Popup.prototype = {
	init: function(container, right){
		var cls = right.hasRulight ? "" : "locked" ;
        var hasZan = right.hasZan;
		var html = [
			"<li class='reply-ico' dace-node='replyQuote'>回复</li>",
			"<li class='report-ico' dace-node='replyReport'>举报</li>"
        ];
        if(hasZan){
            html.push("<li class='zan-ico' dace-node='replyReward'>赞赏</li>");
        }
		html.push("<li class='light-ico' dace-node='replyLight'>亮了</li>");
		html.push("<li class='rulight-ico "+ cls +"'>灭了</li>");

		this.container = $("<ul class='reply-tips'></ul>")
						.attr("style", "display:none")
						.html(html.join(""));

		$(container || "body").append(this.container);
		this.bindEvent();
	},
	bindEvent: function(){
		var self = this;
		this.container.delegate("li","click", function(e){
			var target = $(e.currentTarget);
			if(target.hasClass("locked")){
				dace.send("replyunlightgray");
				Toast.toast("点灭功能暂未完全开放");
				self.hide();
				return;
			}
			var type = "";
			if(target.hasClass("reply-ico")){
				type = "reply";
			}
			if(target.hasClass("report-ico")){
				type = "report";
			}
			if(target.hasClass("zan-ico")){
				type = "zan";
			}
			if(target.hasClass("light-ico")){
				type = "light";
			}
			if(target.hasClass("rulight-ico")){
				dace.send("replyunlight");
				type = "rulight";
			}
			self.container.addClass(type + "-active");
			self.handler(type);
		});
		$(window).on("resize", function(){
			self.hide();
		});

		$(window).on("scroll", function(){
			self.hide();
		});
	},
    getButtonLength: function() {
		return this.container.find("li").size()
	},
    autoContainerAlignCenter: function(len) {
		var btnLen = len || this.getButtonLength();
		if (this._btnLength != btnLen) {
			var left = -(btnLen * 31);
			this.container.css({"margin-left": left, "width": 62 * btnLen });
			this._btnLength = btnLen;
		}
	},
	on: function(name, handler){
		if(this.events[name]){
			this.events[name].push(handler);
		}else{
			this.events[name] = [handler];
		}
	},
	fire: function(name){
		var handlers = this.events[name];
		if(handlers && handlers.length){
			for(var i=0,len=handlers.length;i<len;i++){
				handlers[i]();
			}
		}
	},
	handler: function(type){
		this.fire(type);
		this.hide();
	},
	update: function(top, target){
		// 再次点击消失
		this.container.css({
			"top": top - 24 > 0 ? (top - 24) : 0
		});
		if(this._target === target){
			this.toggle();
			return;
		}
		this._target = target;
        this.autoContainerAlignCenter();
		this.show();
	},
	toggle: function(){
		if(this.isShow){
			this.hide();
		} else{
			this.show();
		}
	},
	show: function(){
		this.isShow = true;
		this.container.show();
	},
	hide: function(){
		this.isShow = false;
		this.container.hide();
		this._target && $(this._target).removeClass("reply-active");
		this.container.removeClass().addClass("reply-tips");
	}
};
var instance = new Popup();
module.exports = instance
