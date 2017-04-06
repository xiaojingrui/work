var Store = require("common:widget/ui-store/ui-store.js");
var storageName = "hupuNewsRead";
var scrollTop = 0;
var replyTop = 0;
var isReach = false;
var timer = null;
var count = 0;
var screenHeight = 0;

var rememberPos = {
	init: function( nid ) {

		var store = new Store(storageName);
		var news_list = store.get() ? JSON.parse(store.get()) : {};

		screenHeight = $(window).height() || $("#height").height();
		replyTop = $("#J_mReply").position().top;

		var imgs = $(".artical-content img"), len = imgs.size();
		imgs.each(function(idx, img){
			// 图片缓存
			if(img.complete){
				count++;
				if(count == len){
					// 兼容安卓不支持scrollTop的方法
					setTimeout(function(){
						if(news_list[nid]!="read"){
							$(window).scrollTop(news_list[nid]);
						}else{
							if(replyTop - screenHeight + 180 >0){
								$(window).scrollTop($("#J_mainContent").height() - screenHeight + 34);
							}
						}
					},100);
				}
			} else{
				img.onload = img.onerror = function(){
					count++;
					if(count == len){
						setTimeout(function(){
							if(news_list[nid]!="read"){
								$(window).scrollTop(news_list[nid]);
							}else{
								if(replyTop - screenHeight + 180 >0){
									$(window).scrollTop($("#J_mainContent").height() - screenHeight + 34);
								}
							}
					},100);
					}
				}
			}
		});

		$(window).on("scroll", function(){
			screenHeight = $(window).height() || $("#height").height();
			replyTop = $("#J_mReply").position().top;
			clearTimeout(timer);
			timer = setTimeout(function() {
				scrollTop = $(this).scrollTop();

				if (!isReach) {
					if (scrollTop >= replyTop - screenHeight) {
						news_list[nid] = "read";
						//看到评论区已到达
						isReach = true;
					} else {
						news_list[nid] = scrollTop;
					}
					store.set(JSON.stringify(news_list));
					//alert(scrollTop+"|"+replyTop+"|"+screenHeight+"|"+JSON.stringify(news_list));
				}
			}, 200);
		});
	}
}

module.exports = rememberPos;
