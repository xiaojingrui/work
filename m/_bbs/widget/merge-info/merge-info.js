
var mergerInfo= {
	getStart:function(){
		var self=this;
		$("#mergeTips").on("click",function(){
	       self.init();
	       return false;
    	})
	},
	init: function() {
		if(document.getElementById('J-merge-global')){
			this.show();
			this.bindEvent();
			return;
		}

		this.render();
		this.show();
		this.bindEvent();
	},
	render: function() {
		this.$elem = $("<div />").attr("id", "J-merge-global").addClass("hp-merge-container");
		$("body").append( this.$elem );
	},
	bindEvent: function() {
		var self = this;
		this.cloBtn=$("#confirmBtn");
		this.cloBtn.on('click', function(e) {
			self.hide();
			return false;
		});

		$(window).bind('resize', function(e) {
			if(IsShareOpen){
				self.show();				
			}
		});
	},
	show: function(){
		IsShareOpen = true;
		var self = this;

		var width = $(window).width();
		var height = $(window).height();
		var docHeight = $(document).height();
		var scrollTop = $(window).scrollTop();


		this.$elem.css({
			"width": width,
			"height": docHeight
		});
		var html='<div class="mergeContainer"><div><p class="mergeMessage">为避免版面混乱 同一类型主题帖会合并到最早的同类型主题帖中，或转水处理。</p><span id="confirmBtn">关闭</span></div></div>';
		this.$elem.html(html);
		var $iconWarp = this.$elem.find(".mergeContainer");
		var $mHeight=$(".mergeContainer>div").height()/2;
		$iconWarp.css("margin-top", scrollTop + height * 0.5 - $mHeight);

		//PC上可行的禁止滚动方法.
		$("html").addClass("hide-body-scroll");
		//兼容手机分享无法滚屏的bug.
		this.$elem.on("touchmove.sharemark",function(e){  
            e.stopPropagation();
            e.preventDefault();
        });
		this.$elem.show();
	},
	hide: function(){
		IsShareOpen = false;
		$("html").removeClass("hide-body-scroll");
		this.$elem.off(".sharemark");

		this.$elem.hide();
	}
};
module.exports=mergerInfo
 
