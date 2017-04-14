!function() {
	var common = pager.common;
	pager.earth = {
		name: "earth",
		show: function(area){
			if(!this.init){
				this.init = true;
				this.container = $("<div class='rotate-earth'></div>");
				var canvas = document.createElement("canvas");
				canvas.width = 40;
				canvas.height = 40;
				this.container.append("<span></span>");
				this.container.append($(canvas));
				$("body").append(this.container);
				this.ctx = canvas.getContext("2d");
				this.loadFrames();
			}
			this.frames = [];
			switch(area){
				case "africa":
					this.frames = [24,22,21,14,13,13,12];
					break;
				case "chinaFoot":
				case "cba":
					this.frames = [41,34,33,31,24,24,23];
					break;
				case "zb":
					this.frames = [43,42,41,34,33,33,32];
					break;
				case "nba":
					this.frames = [11,71,63,62,61,61,54];
					break;
				case "football":
					this.frames = [21,14,13,11,71,71,64];
					break;
			}
			if(this.frames.length == 0){
				this.stop();
			} else{
				this.running = true;
				this.index = 0;
				this.container.show();
			}
		},
		loadFrames: function(){
			var img = this.frameImg = new Image();
			img.src = pager.host + "/img/earth-frames.png?v=" + pager.ver;
		},
		run: function(){
			if(!this.running) return;
			//3帧Draw一次.
			if(pager.renderCount % 3 === 0){
				if(this.index < this.frames.length){
					var frame = this.frames[this.index];
					this.drawFrame(frame);
					this.index++;
				} else{
					this.running = false;
				}
			}

		},
		drawFrame: function(frame){
			var pos = String(frame).split("");
			var ctx = this.ctx;
			var x = (pos[1] - 1) * 161 + 100;
			var y = (pos[0] - 1) * 97;

			ctx.clearRect(0, 0, 40, 40);
			ctx.fillStyle = 'rgba(17,22,43, 1)';
			ctx.beginPath();
			ctx.arc(20, 20, 20, 0, 2 * Math.PI);
			ctx.closePath();
			ctx.fill();
			ctx.drawImage(this.frameImg, x, y, 40, 40 ,0, 0, 40, 40);
		},
		stop: function(){
			this.running = false;
			this.container.hide();
		}
	};
}();