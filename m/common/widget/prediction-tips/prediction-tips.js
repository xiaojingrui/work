var _ =  require('underscore');

var apiUrl = {
    checkResult: '/predict/chkpredict'
};

var predictionTips = {
    ajaxinterval: 360000, // 轮询间隔时间6分钟
    showtime: 10000, // 展示时间
    topPos: $('#J_mTopNav').height(),
    init: function() {
        this.ajaxRoll();
    },
    ajaxRoll: function() {
        var self = this;
        this.timer = setInterval(function() {
            var success = function(data) {
                if(data.code == 200){
                    self.show(data.url);
                }
            };
            self.ajax(apiUrl.checkResult, success);
        }, this.ajaxinterval);
    },
    ajax: function(url, success, error){
        $.ajax({
            type: 'POST',
            url: url,
            dataType: 'json',
            timeout: 3000,
            success: success,
            error: error || function(){}
        });
    },
    show: function(url) {
        var self = this;

        $('body').append(_.template( $("#J_predictNotice").html(), {"url":url}));
        
        this.tips = $('#J_preTips');

        this.setTop();

        $(window).on('scroll', function() {
            self.setTop();
        })        
        
        setTimeout(function() {
            self.tips.addClass('active');
        }, 10);

        setTimeout(function() {

            self.tips
                .removeClass('active')
                .one('transitionend webkitTransitionEnd mozTransitionEnd oTransitionEnd', function () {
                    $(this).remove();
                });
                    
        }, this.showtime);
    },
    setTop: function() {
        var _top = this.topPos < $(window).scrollTop() ? 0 : (44 - $(window).scrollTop());
        
        this.tips.css({
            top: _top
        });
    }
};

module.exports = predictionTips;
