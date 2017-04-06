/**
 * @name 弹出层tips
 * @author yuhongfei@hupu.com
 * @class Popup
 */
var Toast = require("common:widget/ui-toast/ui-toast.js");
var dace = require("common:widget/ui-dace/ui-dace.js");
var version = require("common:widget/ui-versions/ui-versions.js");

var Popup = function() {
	this.events = {};
	this.target = null;
	this.isShow = false;
	this._btnLength = 0;
}
Popup.prototype = {
	init: function(container, isAdmin, ver) {
		var html = [
			"<li class='reply-ico reply-quote' dace-node='comment_reply'>回复</li>"
		];
		if (version.gte(ver, "7.0.8") && !isAdmin) {
			html.push(
				"<li class='report-ico reply-report' dace-node='comment_report'>举报</li>"
			);
		}
		html.push(
			"<li class='light-ico reply-light' dace-node='comment_light'>亮了</li>");
		html.push(
			"<li class='rulight-ico reply-notlight' dace-node='comment_notlight'>灭了</li>"
		);
		if (isAdmin) {
			html.push("<li class='delete-ico' dace-node='replyDelete'>删除</li>");
			html.push("<li class='banned-ico' dace-node='replyBanned'>封禁</li>");
		}
		this.container = $("<ul class='reply-tips'></ul>")
			.attr("style", "display:none")
			.html(html.join(""));

		//自动评论弹层水平居中.
		this.autoContainerAlignCenter();
		$(container || "body").append(this.container);
		this.bindEvent();
	},
	getButtonLength: function() {
		return this.container.find("li").size()
	},
	getTarget: function(){
		return $(this.target)
	},
	autoContainerAlignCenter: function(len) {
		var btnLen = len || this.getButtonLength();
		if (this._btnLength != btnLen) {
			var left = -(btnLen * 32 - 5);
			this.container.css("margin-left", left);
			this._btnLength = btnLen;
		}
	},
	bindEvent: function() {
		var self = this;
		this.container.delegate(".reply-tips li", "click", function(e) {
			var target = $(e.currentTarget);
			var type = "";
			if (target.hasClass("reply-ico")) {
				type = "reply";
			}
			if (target.hasClass("report-ico")) {
				type = "report";
			}
			if (target.hasClass("light-ico")) {
				type = "light";
			}
			if (target.hasClass("rulight-ico")) {
				type = "rulight";
			}
			//点击封禁和删除不处理
			if (target.hasClass("delete-ico") || target.hasClass("banned-ico")) {
				e.stopPropagation();
				return;
			}
			self.container.addClass("active");
			self.handler(type);
		});
		$(window).on("resize", function() {
			self.hide();
		});

		$(window).on("scroll", function() {
			self.hide();
		});
	},
	on: function(name, handler) {
		if (this.events[name]) {
			this.events[name].push(handler);
		} else {
			this.events[name] = [handler];
		}
	},
	fire: function(name) {
		var handlers = this.events[name];
		if (handlers && handlers.length) {
			for (var i = 0, len = handlers.length; i < len; i++) {
				handlers[i](this.target);
			}
		}
	},
	handler: function(type) {
		this.fire(type);
		this.hide();
	},
	update: function(top, target, extra) {
		// 再次点击消失
		this.container.css({
			"top": top - 24
		});
		if (extra && extra.hidereply) {
			//隐藏回复按钮
			this.container.addClass("reply-tips-hide");
			this.autoContainerAlignCenter(this.getButtonLength() - 1);
		} else {
			this.container.removeClass("reply-tips-hide");
			this.autoContainerAlignCenter();
		}

		//移除按钮被点击效果
		this.container.find('li').removeClass("active");
		if (extra && extra.lighted) {
			if (extra.lighted === "1") {
				this.container.find('.reply-light').addClass('active');
			} else if(extra.lighted === "2") {
				this.container.find('.reply-notlight').addClass('active');
			}
		}
		if (this.target === target) {
			this.toggle();
			return;
		}
		this.target = target;
		this.show();
	},
	toggle: function() {
		if (this.isShow) {
			this.hide();
		} else {
			this.show();
		}
	},
	show: function() {
		this.isShow = true;
		this.container.show();
	},
	hide: function() {
		this.isShow = false;
		this.container.hide();
		this.target && $(this.target).removeClass("reply-active");
		this.container.find(".firstOption").attr("selected", "selected");
	}
};

var __intance = null;
module.exports = (function() {
	if (!__intance) {
		__intance = new Popup();
	}
	return __intance;
})();
