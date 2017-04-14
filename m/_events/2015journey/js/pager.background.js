/**
 * pager.background
 * 页面背景
 */
!function() {
	var common = pager.common;
	/**
	 * 粒子发生器
	 * 传配置到发生器，render之后，自己回收.
	 */
	var Particle = function(config){
		for(var x in config){
			if(!this.hasOwnProperty(x)){
				this[x] = config[x];
			}
		}
	}
	Particle.prototype = {
		render: function(callback){
			callback && callback();
		}
	}

	pager.background = {
		start: function() {
			if (!this.init) {
				this.init = true;
				this.container = document.getElementById("background");
				this.ctx = this.container.getContext("2d");
				this.starMaxLength = 40;
				this.starMaxSize = 4;
				this.meteorFlash = 50;
				this.mxSpeed = 0.01;
				this.mySpeed = 0.01;
			}
			this.updateSize();
			this.running = true;
			this.rectdata = [];
			this.meteorData = {};
			this.resetStar();
			this.resetMeteor();
		},
		updateSize: function() {
			var size = Math.min(pager.width, pager.height);
			this.shortBorder = size;
			this.width = pager.width;
			this.height = pager.height;
			this.container.width = pager.width;
			this.container.height = pager.height;
		},
		run: function() {
			if (!this.running) return;
			var ctx = this.ctx;
			var rectData = this.rectdata;
			var rectRealData = this.rectRealData;

			//闪闪的星星
			ctx.clearRect(0, 0, this.width, this.height);
			ctx.save();
			for (var i = 0; i < rectData.length; i++) {
				var star = rectData[i];
				ctx.fillStyle = 'rgba(255,255,255, ' + star.opacity + ')';
				ctx.beginPath();
				star.render(function() {
					if (star.stopGrowing) {
						//星星变小
						star.size -= .02;
						if (star.size < 0) {
							star.size = 0;
							star.canRemove = true;
						}
					} else {
						//星星变大
						if (star.size <= star.maxSize) {
							star.size += .02;
						} else {
							star.stopGrowing = true;
						}
					}
					ctx.arc(star.x, star.y, star.size, 0, 2 * Math.PI);
				});
				ctx.closePath();
				ctx.fill();
				if (star.canRemove) {
					rectData[i] = this.createStar();
				}
			}
			ctx.restore();

			if (pager.renderCount % this.meteorFlash != 0 && this.meteorData) {
				var x = this.meteorData.start.x,
					y = this.meteorData.start.y,
					m = this.meteorData.end.x,
					n = this.meteorData.end.y;
				//只有第一帧的时候计算speed. 优化算法
				if (pager.renderCount % this.meteorFlash === 1) {
					this.mxSpeed = Math.abs(x - m) / this.meteorFlash,
					this.mySpeed = Math.abs(n - y) / this.meteorFlash;
				}

				var lx = x - this.mxSpeed * (pager.renderCount % this.meteorFlash);
				var ly = y + this.mySpeed * (pager.renderCount % this.meteorFlash);

				var lrd = ctx.createLinearGradient(x, y, lx, ly);
				lrd.addColorStop(0, "rgba(200,200,200, 0.001)");
				lrd.addColorStop(.2, "rgba(200,200,200, 0.02)");
				lrd.addColorStop(.4, "rgba(200,200,200, 0.04)");
				lrd.addColorStop(.6, "rgba(200,200,200, 0.1)");
				lrd.addColorStop(.8, "rgba(200,200,200, 0.2)");
				lrd.addColorStop(1, "rgba(200,200,200, 0.3)");
				ctx.beginPath();
				ctx.moveTo(x, y);
				ctx.lineTo(lx, ly);
				ctx.lineWidth = 1;
				ctx.strokeStyle = lrd;
				ctx.closePath();
				ctx.stroke();
			} else {
				this.meteorData = null;
			}
			//流星的频率
			if (pager.renderCount % 500 === 0) {
				this.resetMeteor();
			}

		},
		resetStar: function() {
			this.rectdata = [];
			for (var i = 0; i < this.starMaxLength; i++) {
				this.rectdata.push(this.createStar());
			}
		},
		createStar: function() {
			var maxSize = common.getRandom(this.starMaxSize, 2);
			var star = new Particle({
				x: common.getRandom(this.shortBorder),
				y: common.getRandom(this.shortBorder),
				size: 0,
				maxSize: maxSize,
				stopGrowing: false,
				canRemove: false,
				opacity: (Math.round(Math.random() * 5) / 10)
			});
			return star;
		},
		resetMeteor: function() {
			var half = this.height / 2;
			this.meteorData = {};
			this.meteorData.start = {
				x: this.width,
				y: common.getRandom(half)
			};
			this.meteorData.end = {
				x: -this.width,
				y: half + common.getRandom(this.height)
			};
		},
		stop: function() {
			this.running = false;
		}
	};
}();