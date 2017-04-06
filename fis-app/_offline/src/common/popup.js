/**
 * @name 弹出层tips
 * @author yuhongfei@hupu.com
 * @class Popup
 */
import dace from './dace'
import $ from './zepto'
import { isIOS } from './app'

let Popup = function() {
	this.events = {};
	this.target = null;
	this.isShow = false;
	this.type = "news";
	this._btnLength = 0;
}
Popup.prototype = {
	initNews: function(isAdmin){
		this.type = "news"
		let html = [
			"<li class='reply-ico reply-quote' dace-node='comment_reply'>回复</li>"
		];
		if (!isAdmin) {
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
		$("body").append(this.container);
		this.bindEvent();
	},
	initBBS: function(right){
		this.type = "bbs"
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

		$("body").append(this.container);
		this.bindEvent();
	},
	getButtonLength: function() {
		return this.container.find("li").size()
	},
	getTarget: function(){
		return $(this.target)
	},
	autoContainerAlignCenter: function(len) {
		let btnLen = len || this.getButtonLength();
		if (this._btnLength != btnLen) {
			if("news" == this.type){
				let left = -(btnLen * 32 - 5);
				this.container.css("margin-left", left);
			}
			if("bbs" == this.type){
				let left = -(btnLen * 31);
				this.container.css({"margin-left": left, "width": 62 * btnLen });
			}
			this._btnLength = btnLen;
		}
	},
	bindEvent: function() {
		let self = this;
		this.container.delegate(".reply-tips li", "click", function(e) {
			let target = $(e.currentTarget);
			let type = "";
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
			if (target.hasClass("zan-ico")){
				type = "zan";
			}
			//点击封禁和删除不处理
			if (target.hasClass("delete-ico") || target.hasClass("banned-ico")) {
				e.stopPropagation();
				return;
			}
			self.container.addClass("active");
			self.handler(type);
		});

		if(!isIOS){
			$(window).on("resize", function() {
				self.hide();
			});

			$(window).on("scroll", function() {
				self.hide();
			});
		}
	},
	on: function(name, handler) {
		if (this.events[name]) {
			this.events[name].push(handler);
		} else {
			this.events[name] = [handler];
		}
	},
	fire: function(name) {
		let handlers = this.events[name];
		if (handlers && handlers.length) {
			for (let i = 0, len = handlers.length; i < len; i++) {
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
			"top": Math.max(top - 24, 30)
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

let __intance = null;
module.exports = (function() {
	if (!__intance) {
		__intance = new Popup();
	}
	return __intance;
})();
