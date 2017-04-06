var Store = require("common:widget/ui-store/ui-store.js");
var storageName = "hupuRecap";
var scrollTop = 0;
var timer = null;
var count = 0;
var screenHeight = 0;

var rememberPos = {
	init: function(id) {
		var store = new Store(storageName);
		var recap_list = store.get() ? JSON.parse(store.get()) : {};

		screenHeight = $(window).height();

		var imgs = $("img"), len = imgs.size();
		imgs.each(function(idx, img){
			// 图片缓存
			if(img.complete){
				count++;
				if(count == len){
					// 兼容安卓不支持scrollTop的方法
					setTimeout(function(){
						if(recap_list[id]!="over"){
							$(window).scrollTop(recap_list[id]);
						}else{
							$(window).scrollTop($(document).height() - screenHeight);
						}
					},100);
				}
			} else{
				img.onload = img.onerror = function(){
					count++;
					if(count == len){
						setTimeout(function(){
							if(recap_list[id]!="over"){
								$(window).scrollTop(recap_list[id]);
							}else{
								$(window).scrollTop($(document).height() - screenHeight);
							}
						},100);
					}
				};
			}
		});

		$(window).on("scroll", function(){
			screenHeight = $(window).height();
			clearTimeout(timer);
			timer = setTimeout(function() {
				scrollTop = $(this).scrollTop();
				if (scrollTop >= $(document).height() - screenHeight) {
					recap_list[id] = "over";
				} else {
					recap_list[id] = scrollTop;
				}
				store.set(JSON.stringify(recap_list));
			}, 200);
		});

		if(Object.getOwnPropertyNames(recap_list).length >= 100){
			recap_list = {};
		}
	}
}

module.exports = rememberPos;
