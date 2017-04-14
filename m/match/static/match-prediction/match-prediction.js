(function(){
    var _ = require('underscore');
    var Tips = require('common:widget/ui/tips/tips.js');


    var apiUrl = {
        recentPredict: '/predict/immediate',
        addPredict: '/predict/add'
    }

    var jumpLink = {
        bind: function() {
            $('#J_myPredict').on('click', function(e) {

                e.preventDefault();

                if(!HPM.isLogin){
                    HPM.popLogin();
                    return;
                }else{
                    location.href = $(this).data('href');
                }
            })
            
        }
    };

    jumpLink.bind();

    /**
     * [predictScroll 底部最新预测消息滚动提示]
     * @type {Object}
     */
    var predictScroll = {
        interval: 200000, // 轮询间隔时间3分20秒
        scrollSpeed: 5000, // 滚动间隔时间5秒
        screenWidth: document.documentElement.clientWidth,
        timer: null, // 停留定时器
        initAjax: function() {
            this.ajaxFn();
            this.pollAjax();
        },
        pollAjax: function() {
            var self = this;

            setInterval(function() {
                self.ajaxFn();
            },this.interval);

        },
        ajaxFn: function() {
            var self = this;

            $.ajax({
                url: apiUrl.recentPredict,
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    if(data.code == 200) {

                        if(data.data.length > 0){
                            $('body').append(_.template( $("#predict-tips").html(), {datas: data.data}));
                            self.init();
                        }
                    }else{
                        return false;
                    }
                }
            });
        },
        init: function() {
            var self = this;
            this.scrollWrap = $('#J_preScroll');
            this.scrollList = this.scrollWrap.find('ul');
            this.scrollItem = this.scrollList.find('li');
            this.scrollItem.width(this.screenWidth);
            this.len = this.scrollItem.length;
            this.count = 0;
            this.show();
            
        },
        show: function() {
            var self = this;
            self.scrollWrap
                .animate({
                    bottom: 0
                }, 300, function() {
                    self.showAll();
                    self.scrollStart();
                })
            self.stopTouch();
        },
        hide: function() {
            var self = this;
            setTimeout(function() {
                self.scrollWrap
                    .animate({
                        bottom: '-28px'
                    }, 300, function() {
                        self.scrollWrap.remove();
                    })
            }, this.scrollSpeed);

        },
        // 阻止手指触摸滚动
        stopTouch: function() {
            this.scrollItem.find('p').on('touchstart touchmove touchend', function(e){
                e.preventDefault();
                e.stopPropagation();
            })
        },
        scrollStart: function() {
            var self = this;
            if(this.len ==  1){
                this.hide();
                return false;
            }
            this.timer = setTimeout(function() {
                self.scrollFn();
            }, this.scrollSpeed);
        },

        scrollStop: function() {
            clearTimeout(this.timer);
            this.timer = null;
        },

        scrollFn: function() {
            var self = this;

            this.scrollStop();

            this.count++;

            this.scrollList.animate({
                left: -self.count * self.screenWidth,
            }, 800, function() {
                self.showAll();
                if(self.count < self.len - 1){
                    self.scrollStart();
                }else{
                    self.scrollStop();
                    self.hide();
                }

            });
        },

        // 显示完整信息
        showAll: function() {

            var sWidth = $(this.scrollItem.eq(this.count).find('p'))[0].scrollWidth;
                oWidth = $(this.scrollItem.eq(this.count))[0].offsetWidth,
                resWidth = sWidth - oWidth,
                self = this;

            if(resWidth > 0) {
                setTimeout(function(){
                    self.scrollTo( resWidth, $(self.scrollItem.eq(self.count).find('p')) );
                }, 1000);
            }

        },
        scrollTo: function(distance, obj){   
            var n = 0, timer = null, that = this;

            var smoothScroll = function(distance){
                var per = Math.round(distance / 60);
                n = n + per;
                if(n > distance){
                    window.clearInterval(timer);
                    return false;
                }            
                obj.scrollLeft(n);
            };

            timer = window.setInterval(function(){
                smoothScroll(distance);
            }, 20);
        }

    };

    predictScroll.initAjax();
    
    
    /**
     * [directPop 预测弹窗]
     * @type {Object}
     */
    var directPop = {
        init: function() {
            this.predictBtnSet = $('.J_preBtn');
            this.preResult = null;
            this.preBtn = null;

            this.bind();
        },
        bind: function() {
            var self = this;

            this.predictBtnSet.on('click', function(e) {
                e.stopPropagation();
                e.preventDefault();
                if(!HPM.isLogin){
                    HPM.popLogin();
                    return;
                }

                self.preLink = $(this).parents('.predict-link');

                // 若该场比赛下方没有预测状态栏，则动态创建
                if(self.preLink.find('.predict-result p').length <= 0) {
                    self.preLink.append('<div class="predict-result"><p></p></div>');
                }
                
                self.preBtn = $(this);

                self.preResult = self.preLink.find('.predict-result p');

                self.checkPredict();
                
            });

        },
        checkPredict: function() {
            var type = this.preBtn.data('type'),
                gid = this.preBtn.data('gid'),
                self = this;
                
            $.ajax({
                url: apiUrl.addPredict,
                type: 'POST',
                dataType: 'json',
                data: {
                    type: type,
                    gid: gid
                },
                success: function(data) {
                    if(data.code == 400) {
                        Tips("您已经参加过该场预测了");
                        var res = data.data != -1 ? ('您预测：<span class="sp">'+ data.data + '</span>胜') : ('您预测的是：<span class="sp">两队打平</span>');
                        self.preResult.html(res);
                        self.preBtn.hide();
                    }else{
                        self.render();
                        self.predictFn();
                    }
                }
            })
        },
        render: function(item) {
            var data = {
                "home": this.preBtn.data('home'),
                "away": this.preBtn.data('away'),
                "homeid": this.preBtn.data('homeid'),
                "awayid": this.preBtn.data('awayid'),
                "type": this.preBtn.data('type'),
                'gid': this.preBtn.data('gid')
            };

            $('body').append(_.template( $("#predict-popup").html(), data));
            this.scrollStop();
        },
        scrollStop: function() {
            this.popWrap = $('#J_prePopup');

            $('html,body').addClass('m-scroll-stop');

            this.popWrap.on('touchmove.popup', function(e) {
                e.stopPropagation();
                e.preventDefault();
            });

        },
        scrollStart: function() {
            $('html,body').removeClass('m-scroll-stop');
            this.popWrap.off('touchmove.popup');
        },
        predictFn: function() {
            var self = this;

            this.mask = $('#J_mask');
            this.preOption = this.popWrap.find('.predict-option');
            this.optionItem = this.popWrap.find('.option-item');
            this.cancel = $('#J_cancel');
            this.confirm = $('#J_confirm');

            this.cancel.on('click', function() {
                self.hide();                    
            });

            this.optionItem.on('click', function() {
                $(this).addClass('active').siblings().removeClass('active');
                self.confirm.addClass('ready');
                self.cancel.addClass('ready');
            });

            this.confirm.on('click', function() {
                if(!$(this).hasClass('ready')){
                    return;
                }

                var result = self.popWrap.find('.active').data('value'),
                    type = self.preOption.data('type'),
                    gid = self.preOption.data('gid'),
                    predict = self.popWrap.find('.active').data('id');

                $.ajax({
                    url: apiUrl.addPredict,
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        type: type,
                        gid: gid,
                        predict: predict
                    },
                    success: function(data) {
                        if(data.code == 200) {
                            var res = predict != -1 ? ('您预测：<span class="sp">'+ result + '</span>胜') : '您预测的是：<span class="sp">两队打平</span>';
                            self.preResult.html(res);
                        }
                        self.hide();
                        self.preBtn.hide();
                    }
                })
                
            });

        },

        hide: function() {
            this.mask.remove();
            this.popWrap.remove();
            this.scrollStart();
        }

    };

    directPop.init();

})()