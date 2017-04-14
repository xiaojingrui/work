/**
 * @file 页面工具栏
 * @authoer yuhongfei@hupu.com
 **/

"use strict";
//默认配置
var defaultConfig = {
	today: false,
	todayHandler: function(){
		//do something.
	},
	refreshHandler: function(){
		location.reload();
	},
	backtopHandler: function(){
		$(window).scrollTop(0);
	},
	refresh: false,
	reply: false,
	post: false,
	replyHandler: function(){

	},
	postHandler: function(){

	}
};
var pageId = __daceDataNameOfPage;

var pageTools = {
	init: function(){
		if(this.initStatus) return;
		this.initStatus = true;

		this.winHeight = $(window).height();
		this.backtopShowStatus = false;

		this.$container = null;
		this.$refresh = null;
		this.$today   = null;
		this.$backtop = null;
		this.$reply = null;
		this.$post = null;

		this._initContainer();
		this.bindEvent();
	},
	initTools: function(options) {
		if(!this._initToolsStatus){
			this._initToolsStatus = true;

			var config = $.extend(defaultConfig, options);
			if (config.refresh) {
				this.$refresh = $("<div>")
							  .attr("dace-node", pageId + "_refresh")
							  .addClass("ui-refresh")
							  .on("click", $.proxy(config.refreshHandler, this));
				this.$container.prepend(this.$refresh);
			}

			if (config.today) {
				this.$today = $("<div>")
								.attr("dace-node", pageId + "_today")
								.addClass("ui-today-link")
								.text("今天")
								.on("click", $.proxy(config.todayHandler, this));
				this.$container.prepend(this.$today);
			}

			if (config.reply) {
				this.$reply = $("<div>")
								.attr("dace-node", pageId + "_reply")
								.addClass("ui-reply").html("回复")
								.on("click", $.proxy(config.replyHandler, this));
				this.$container.append(this.$reply);
				$(".ui-reply").on("click",function(){
					if( $("#J-reply-box").length ) {
					 $('html,body').scrollTop($("#J-reply-box").offset().top);
					}
				})
			}
			if (config.post) {
				this.$post = $("<a href='/bbs/post/"+HPM.fid+"'>")
								.attr("dace-node", pageId + "_post")
								.addClass("ui-post").html("发帖")
								.on("click", $.proxy(config.postHandler, this));
				this.$container.append(this.$post);
			}
		}
		this.render();
	},
	showBacktop: function(){
		if(!this._initBackTopStatus){
			this._initBackTopStatus = true;
			this.$backtop = $("<div>")
							.attr("dace-node", pageId + "_up")
							.addClass("ui-backtop")
							.html("<em></em>")
							.on("click", $.proxy(defaultConfig.backtopHandler, this));

			if(this.$reply){
				this.$reply.before(this.$backtop);
			} else{
				this.$container.prepend(this.$backtop);
			}
		}
		this.render();
	},
	hideBacktop: function(){
		if(this.$backtop){
			this.$backtop.hide();
		}
		this.render();
	},
	bindEvent: function(){
		var self = this;

		$(window).on("scroll", function(){
			var scrollTop = $(window).scrollTop();
			var status;

			if(scrollTop >= self.winHeight * 2){
				status = true;
			} else{
				status = false;
			}
			//论坛滚动高度超过回复框则隐藏
			if( $("#J-reply-box").length ) {
				var bbsReply = $("#J-reply-box").offset().top-$(window).height();
				if(scrollTop >= bbsReply) {
					$(".ui-reply").hide();
				}else{
					$(".ui-reply").show();
				}
			}
			
			//校验页面状态. 状态改变再决定是否显示.
			if(self.backtopShowStatus === status){
				return;
			}
			self.backtopShowStatus = status;

			if(status){
				self.showBacktop();
			} else{
				self.hideBacktop();
			}
		});
	},
	_initContainer: function(){
		this.$container = $("<div>").addClass("ui-page-tools");
		$(document.body).append(this.$container);
	},
	render: function(type){
		if(this.backtopShowStatus && this.$backtop){
			this.$backtop.show();
		}
		if(this.$refresh){
			this.$refresh.show();
		}
		if(this.$today){
			this.$today.show();
		}
		this.$container.show();
	}
};

module.exports = {
	init : function(){
		pageTools.init();
	},
	initTools: function(config){
		pageTools.init();
		pageTools.initTools(config);
	}
}
