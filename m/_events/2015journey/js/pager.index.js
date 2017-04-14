/**
 * pager.index
 * 首页处理
 */
!function() {
	var common = pager.common;
	pager.index = {
		name : "index",
		start: function() {
			if(!this.init){
				this.init = true;
				this.posCanvasHeight = 140;
				this.posCanvasWidth = 70;
				this.rects = [110,50,75,95];
				this.rectStyles = ["#eac506","#d27020","#ee964f","#fdad3c"];
				this.container = $("#index");
				this.indexTpl = this.container.find("#index-tpl").html();

				this.bindEvent();
				var formatNum = function (count){
				  return count < 10 ? "0" + count : count;
				}
				var indexHeader = pager.showData.header.str_sy;
				var user = pager.showData.userbaseinfo;
				var texts = indexHeader.split(/\n/);
				if(indexHeader){
					var datetime = "";
					if(user.regdate){
						var date = new Date(user.regdate * 1000);
						datetime = "<em>" + formatNum(date.getDate()) + "</em> " + formatNum(date.getMonth() + 1) +"月, " + date.getFullYear() + " ";
					}
					texts = [datetime + user.address].concat(texts);
					texts = "<li>" + texts.join("</li><li>") + "</li>";
				}

				var avatar = pager.showData.userbaseinfo.headimg || "//w1.hoopchina.com.cn/hybrid/resource/avatar/man.png";
				var html = _.template(this.indexTpl)({
					isLogin: pager.isLogin,
					userType: pager.userType,
					host: pager.host,
					header: pager.showData.header,
					user: pager.showData.userbaseinfo,
					avatar: avatar,
					text: texts
				});
				this.container.html(html);

				this.posCanvas = this.container.find(".earth-pos");
				if(this.posCanvas && this.posCanvas.size()){
					this.canvasRotate = 0;
					var containerCanvas = this.posCanvas[0];
					containerCanvas.width = this.posCanvasWidth;
					containerCanvas.height = this.posCanvasHeight;
					this.ctx = containerCanvas.getContext("2d");
				}

				this.earthTitle = this.container.find(".earth-title");
				this.texts = this.container.find(".text-list li");
				if(!this.texts.size()){
					this.texts = this.container.find(".text-shadow");
				}
				this.textSee = this.container.find(".index-see");
				
			}
			this.lastRenderCount = pager.renderCount;
			this.resetRect();

			this.running = true;
		},
		bindEvent: function(){
			this.container.delegate(".mine", common.eventName, function(){
                common.showSearch();
            });

            //监听键盘的keyDown
            $(document).on("keydown", function(e){
                if(e.keyCode == 13){
                    common.checkUser();
                }
            });
		},
		run: function() {
			if (!this.running) return;
			var self = this;
			//文本逐个显示出来.
			if(this.texts.size() && !this.initText){
				this.initText = true;
                var duration = 500;
                this.texts.each(function(){
                    duration += 600;
                    $(this).transition({
                        opacity: 1,
                        translate: [0,20],
                        delay : duration
                    }, 500);
                });
                duration += 600;
                this.textSee.transition({
                    opacity: 1,
                    translate: [0,20],
                    delay : duration
                }, 500);
			}

			if(this.ctx){
					var ctx = this.ctx;
					//旋转的圆环
					ctx.clearRect(0, 0, this.posCanvasWidth, this.posCanvasHeight);
					ctx.save();
					ctx.beginPath();
					ctx.scale(1, 0.8);
					ctx.translate(this.posCanvasWidth / 2 - 8, 150);
					this.canvasRotate += 5;
					ctx.rotate(this.canvasRotate * Math.PI / 180);
					ctx.arc(0, 0, 12, 0, 1.75 * Math.PI, false);
					ctx.strokeStyle = "#de5512";
					ctx.lineWidth = 2;
					ctx.stroke();
					ctx.closePath();
					ctx.restore();

					//波动的rect
					var rects = this.rects;
					var rectStyles = this.rectStyles;
					var markEnd = true;

					ctx.save();
					ctx.beginPath();
					ctx.translate(this.posCanvasWidth / 2, this.posCanvasHeight / 2);
					ctx.rotate(185 * Math.PI / 180);
					for(var i = 0;i < rects.length;i++){
						var maxH = self.posCanvasHeight - rects[i];
						this.rectHeight[i] = this.rectHeight[i] + 0.8;
						var isEnding = this.rectHeight[i] < maxH;
						var h = isEnding ? this.rectHeight[i] : maxH;
						if(isEnding){
							markEnd = false;
						}
						var l = (self.posCanvasWidth / 2) - 39 + 4 * i;
						var t = -46;
						if(i == 0 || i ==3){
							t = -52;
						}
						ctx.fillStyle = rectStyles[i];
						ctx.fillRect(l, t, 1.5, h);
					}
					ctx.closePath();
					ctx.restore();

					if(markEnd && this.earthTitle.size()){
						this.running = false;
						this.earthTitle.transition({
	                        opacity: 1,
	                        translate: [0,-20]
	                    }, 500);
					}
			} else{
				this.running = false;
			}
		},
		resetRect: function(){
			this.rectHeight = [0,0,0,0];
		},
		stop: function() {
			this.running = false;
			this.initText = false;
			this.initTitle = false;
			if(this.earthTitle.size()){
				this.earthTitle.removeAttr("style");
			}
		}
	};
}();