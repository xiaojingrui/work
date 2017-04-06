/**
 *  @name 模拟a链接跳转
 *  @description 除a, input, textarea, button外， 其他元素不支持-webkit-tab-highlight-color属性 所以只能通过点击事件模拟，最佳解决方案:active + body添加touchstart空方法
 **/

 var TapLink = {

 	init: function(parentSelector){
 		var current = null;

		parentSelector.delegate(".link", "click", function(e){
			current = $(e.currentTarget);
			window.location.href = current.attr("link");
		});
 	}
 };

 module.exports = TapLink;
