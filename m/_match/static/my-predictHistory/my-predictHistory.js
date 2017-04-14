(function(){
    var Distribute = {
        init: function() {
            this.wrap = $('#J_circleWrap');
            if(this.wrap.length <= 0){
                return;
            }
            this.$large = this.wrap.find('.large');
            this.$medium = this.wrap.find('.medium');
            this.$small = this.wrap.find('.small');
            this.$circle = this.wrap.find('.predict-team');

            for(var i = 0; i < this.$circle.length*2; i++) {
                this.wrap.append('<div class="box"></div>');
            }

            this.$box = this.wrap.find('.box');
            this.lRadius = 80;
            this.mRadius = 58;
            this.sRadius = 42;
            this.count = 0;
            this.cross = 40;// 格子中圆心与固定圆心相交范围
            this.boxWidth = Math.floor(this.$box.width());
            this.boxHeight = Math.floor(this.$box.height());
            this.boxRadius = this.boxWidth / 2;
            this.boxRadiusH = this.boxHeight / 2;
            // console.log(this.boxRadius);
            this.mPos = [];
            this.boxCenter = [];
            this.staticCenter = [];
            this.setLargePos();
            this.setMediumPos();

            this.getBoxCenter();
            this.compareCross();
        },

        // 设置大圆的位置
        setLargePos: function() {
            this.wrap.css({
                height: $(window).height() - 45
            })
            this.$large.css({
                left: '50%',
                marginLeft: -this.lRadius + 'px',
                top: '15%',
                opacity: 1
            });
            this.lLeft = parseInt(this.$large.offset().left);
            this.lTop = parseInt(this.$large.offset().top - 45);
            this.lCenter = [this.lLeft+this.lRadius, this.lTop+this.lRadius];
            this.staticCenter.push({left: this.lCenter[0],top: this.lCenter[1]});
        },

        // 设置中圆的位置，循环放至四个象限
        setMediumPos: function() {

            for(var i = 0,len = this.$medium.length; i < len; i++){
                this.setQuadrant(i);
                this.$medium.eq(i).css({
                    left: this.mPos[i].left,
                    top: this.mPos[i].top,
                    opacity: 1

                });
                this.staticCenter.push({
                    left: this.mPos[i].left + this.mRadius,
                    top: this.mPos[i].top + this.mRadius
                });
            }
        },

        // 设置四个象限的可用位置 用来放中圈
        setQuadrant: function(i) {
            switch (i){
                case 0:
                    var leftMin = this.lCenter[0] + 10,
                        leftMax = window.innerWidth - this.mRadius*2 - 10,
                        topMin = 5,
                        topMax = this.lCenter[1] - this.mRadius*2;
                    break;
                case 1: 
                    var leftMin = this.lCenter[0] - 10,
                        leftMax = window.innerWidth - this.mRadius*2 - 10,
                        topMin = this.lCenter[1] + this.lRadius - 30 ,
                        topMax = this.lCenter[1] + this.lRadius ;
                    break;
                case 2: 
                    var leftMin = 0,
                        leftMax = this.lCenter[0] - this.mRadius*2 - 30,
                        topMin = this.lCenter[1] + this.lRadius - 30 ,
                        topMax = this.lCenter[1] + this.lRadius ;

                    break;
                case 3:
                    var leftMin = 0,
                        leftMax = this.lCenter[0] - this.mRadius*2 - 30,
                        topMin = 5,
                        topMax = this.lCenter[1] - this.mRadius*2;
                    break;
            }

            var result = this.getAvailablePos(leftMin, leftMax, topMin, topMax);

            this.mPos.push(result);

        },

        // 随机获取一个可用的pos值
        getAvailablePos: function(leftMin, leftMax, topMin, topMax) {
            var leftRange = this.getRandomInt(leftMin, leftMax),
                topRange = this.getRandomInt(topMin, topMax);
            
            return {
                left: leftRange,
                top: topRange
            }

        },

        // 随机获取最小值与最大值之间的整数
        getRandomInt: function(min, max) {
            return Math.floor(Math.random() * (max - min) + min);
        },

        // 获取小圆参照盒子的圆心
        getBoxCenter: function() {
            var self = this;
            this.$box.each(function(index, el) {

                var boxLeft = parseInt($(this).offset().left) + self.boxRadius ,
                    boxTop = parseInt($(this).offset().top - 50) + self.boxRadiusH ;

                var boxCenter = {
                    left: boxLeft,
                    top: boxTop
                };

                self.boxCenter.push(boxCenter);
                // $('body').append('<span style="position: absolute;z-index:50;width: 4px;height: 4px;background: blue;left:'+boxLeft+'px;top:'+boxTop+'px">');
            });
        },

        // 小圆参照盒子的圆心去比对以生成的一个大圆四个中圆的圆心，判断是否相交，即格子是否能使用
        compareCross: function() {
            for(var i = 0,len = this.boxCenter.length; i < len; i++) {
                var count = 0;
                
                // 循环获取能使用的格子
                for(var j = 0, len2 = this.staticCenter.length; j < len2; j++) {
                    if(j == 0) {
                        var circleR = this.lRadius;
                    }else{
                        var circleR = this.mRadius;
                    }
                    var a = Math.abs(this.boxCenter[i].left - this.staticCenter[j].left),
                        b = Math.abs(this.boxCenter[i].top - this.staticCenter[j].top),
                        c = Math.ceil(Math.sqrt(Math.pow(a,2)+Math.pow(b,2))),
                        l = this.boxRadius + circleR;
                            
                    if( c < l - this.cross ){
                        break;
                    }
                    count++;

                }
                // 循环能使用的格子 取出随机的位置放小圆
                if(count == this.staticCenter.length){

                    var leftMin = this.boxCenter[i].left - this.boxRadius ,
                        leftMax = this.boxCenter[i].left - this.boxRadius + this.boxWidth - this.sRadius*2,
                        topMin = this.boxCenter[i].top - this.boxRadiusH ,
                        topMax = this.boxCenter[i].top - this.boxRadiusH + this.boxHeight - this.sRadius*2;

                    var availPos = this.getAvailablePos(leftMin, leftMax, topMin, topMax);

                    this.$small.eq(this.count).css(availPos);
                    this.$small.eq(this.count).css({opacity: 1});

                    this.count++;
                }
            }
            this.bottomTips();
            this.removeBox();
        },
        // 移除小圆参照的盒子
        removeBox: function() {
            this.$box.remove();
        },

        bottomTips: function() {
            // 根据不同的情况排放底部的提示
            var style = '';
            if(this.$small.length){
                var bottomPos = this.$small.last().offset().top + this.sRadius * 2 + 50;
                if( bottomPos < window.innerHeight){
                    style = 'bottom:0px;';
                }else{
                    style = 'top:'+bottomPos+'px;';
                }
            }else{

                if(window.innerHeight < 390) {
                    $('.predict-team').each(function(index, el) {
                        var bottomPos = $(el).offset().top + $(el).height() + 20;
                        if( bottomPos > window.innerHeight ){
                            style = 'top:'+bottomPos+'px;';
                            return false;
                        }else{
                            style = 'bottom:10px;';
                        }
                    });

                }else{
                    style = 'bottom:10px;';

                }
            }

            this.wrap.append('<div style="position: absolute;left: 0;'+style+'width:100%;text-align:center;line-height: 30px;color:#999;">预测结果每24小时更新一次</div>')
        }

    };

    Distribute.init();
    
})()