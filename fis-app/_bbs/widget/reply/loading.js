/**
 * @name loading框
 * @author yuhongfei@hupu.com
 * @description loading框
 */
var Loading = function (){
	this.loadingCallback = null;
	this.defaultTimeCount = 0;
};
Loading.prototype = {
	init : function(container) {
		var html = [
			    '<div class="loading">',
			        '<div class="loading-content"><span class="timecount">', this.defaultTimeCount ,'</span></div>',
			        '<p>正在读取内容，请耐心等候</p>',
			    '</div>'
			].join("");
		this.container = $("<div class='detail-loading'></div>").html(html);
		$(container || "body").append(this.container);
		this.timeCountContainer = this.container.find(".timecount");
	},
	show: function(callback, timecount){
		var count = timecount || this.defaultTimeCount;
		this.container.show();
		this.timeCountContainer.text(count);
		this.startRun(count);
		this.loadingCallback = callback;
	},
	startRun: function(count){
		var self = this;
		setTimeout(function(){
			count--;
			if(count >= 0){
				self.timeCountContainer.text(count);
				self.startRun(count);
			} else{
				self.hide();
				self.loadingCallback && self.loadingCallback();
			}
		}, 1000);
	},
	hide: function(){
		this.container.hide();
	}
};
var __intance = null;
module.exports = (function(){
	if(!__intance){
		__intance = new Loading();
	}
	return __intance;
})();
