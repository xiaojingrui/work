/**
 * @Description: 下拉到底部和上拉到顶部再拉就出现刷新效果
 * @Author: wangjun
 * @Update: 2015-05-14 16:00
 * @version: 1.0
 * @Github URL: https://github.com/nevergiveup-j/Zepto.refresh
 */

!function(win, $){

    "use strict";

    /**
     * 工具库
     * @type {Object}
     */
    var Util = {
        elementStyle: document.createElement('div').style,
        // 判断浏览器内核类型
        vendor: function() {
            var vendors = ['t', 'webkitT', 'MozT', 'msT', 'OT'],
                transform,
                i = 0,
                l = vendors.length;

            for ( ; i < l; i++ ) {
                transform = vendors[i] + 'ransform';
                if ( transform in Util.elementStyle ) {
                    return vendors[i].substr(0, vendors[i].length-1);
                }
            }

            return false;
        },
        // 判断浏览器来适配css属性值
        prefixStyle: function(style) {
            if ( Util.vendor() === false ) return false;
            if ( Util.vendor() === '' ) return style;

            return Util.vendor() + style.charAt(0).toUpperCase() + style.substr(1);
        },
        // 判断是否支持css transform-3d（需要测试下面属性支持）
        hasPerspective: function(){
            var ret = Util.prefixStyle('perspective') in Util.elementStyle;
            if ( ret && 'webkitPerspective' in Util.elementStyle ) {
                Util.injectStyles('@media (transform-3d),(-webkit-transform-3d){#modernizr{left:9px;position:absolute;height:3px;}}', function( node, rule ) {
                    ret = node.offsetLeft === 9 && node.offsetHeight === 3;
                });
            }
            return !!ret;
        },
        translateZ: function(){
            if(Util.hasPerspective){
                return ' translateZ(0)';
            }else{
                return '';
            }
        }
    }

    // 分享默认配置
    var defaults = {
        // 内容ID
        contentEl: '#J_content',
        // 默认开启刷新
        isRefresh: true,
        // 下拉可刷新高度
        distanceToRefresh: 50,
        // 触摸移动的方向
        movePosition   : null,
        // 刷新回调
        refreshCallback: function() {

        },
        // 加载更多回调
        loadingMoreCallback: function() {

        }
    };

    var viewHeight = $(window).height();


    function Refresh( $this, options ) {

        this.$wrap = $this;

        this.opts = $.extend(true, {}, defaults, options || {});

        this.$content = $(this.opts.contentEl);

        this.startY = 0;
        this.isPullToRefresh = false;
        this.isLoading = false;
        this.wrapHeight = this.$content.height();
        this.oldScrollTop = 0;

        this.scrollTop = $(window).scrollTop();
        this.init();
    };


    /**
     * 初始化
     */
    Refresh.prototype.init = function(){
        this.loadingRender();
        this.bind();
    };

    /**
     * loading加载
     */
    Refresh.prototype.loadingRender = function(){
        var that = this;

        var refreshTpl = [
            '<style>',
            '.preloader-refresh {display:none;width: 100%;text-align: center;height: 50px;line-height:50px;}',
            '.preloader-refresh .loading-inner {margin-left:-20px;margin-right:5px;}',
            '.preloader-refresh .loading-inner i {display: inline-block;vertical-align: middle;width: 10px;height: 10px;margin-right: 3px; -webkit-transform: scale(0.3);transform: scale(0.3);border-radius: 50%; -webkit-animation: preloader-loading 0.4s infinite alternate; -moz-animation: preloader-loading 0.4s infinite alternate;animation: preloader-loading 0.4s infinite alternate;background-color: #000;}',
            '.preloader-refresh .loading-inner .loading-point-1{-webkit-animation-delay: 0;animation-delay: 0;}',
            '.preloader-refresh .loading-inner .loading-point-2{-webkit-animation-delay: 0.2s;animation-delay: 0.2s;}',
            '.preloader-refresh .loading-inner .loading-point-3{-webkit-animation-delay: 0.4s;animation-delay: 0.4s;}',
            '@-webkit-keyframes preloader-loading {',
                '0% { -webkit-transform: translateY(0) scale(0.3);transform: translateY(0) scale(0.3);opacity: 0;}',
                '100% { -webkit-transform: scale(1);transform: scale(1);background-color: #fff;opacity: 1;}',
            '}',
            '@-webkit-keyframes preloader-loading {',
                '0% { -webkit-transform: translateY(0) scale(0.3);transform: translateY(0) scale(0.3);opacity: 0;}',
                '100% { -webkit-transform: scale(1);transform: scale(1);background-color: #fff;opacity: 1;}',
            '}',
            '</style>',
            '<div class="preloader-refresh">',
                '<span class="loading-inner">',
                    '<i class="loading-point-1"></i>',
                    '<i class="loading-point-2"></i>',
                    '<i class="loading-point-3"></i>',
                '</span>',
                '下拉刷新',
            '</div>'
        ].join('');


        var moveTpl = [
            '<style>',
            '.preloader-loading-more {display:none;width: 100%;text-align: center;height: 50px;line-height:50px;}',
            '.preloader-loading-more .loading-inner {margin-left:-20px;margin-right:5px;}',
            '.preloader-loading-more .loading-inner i {display: inline-block;vertical-align: middle;width: 10px;height: 10px;margin-right: 3px; -webkit-transform: scale(0.3);transform: scale(0.3);border-radius: 50%; -webkit-animation: preloader-loading 0.4s infinite alternate; -moz-animation: preloader-loading 0.4s infinite alternate;animation: preloader-loading 0.4s infinite alternate;background-color: #000;}',
            '.preloader-loading-more .loading-inner .loading-point-1{-webkit-animation-delay: 0;animation-delay: 0;}',
            '.preloader-loading-more .loading-inner .loading-point-2{-webkit-animation-delay: 0.2s;animation-delay: 0.2s;}',
            '.preloader-loading-more .loading-inner .loading-point-3{-webkit-animation-delay: 0.4s;animation-delay: 0.4s;}',
            '@-webkit-keyframes preloader-loading {',
                '0% { -webkit-transform: translateY(0) scale(0.3);transform: translateY(0) scale(0.3);opacity: 0;}',
                '100% { -webkit-transform: scale(1);transform: scale(1);background-color: #fff;opacity: 1;}',
            '}',
            '@-webkit-keyframes preloader-loading {',
                '0% { -webkit-transform: translateY(0) scale(0.3);transform: translateY(0) scale(0.3);opacity: 0;}',
                '100% { -webkit-transform: scale(1);transform: scale(1);background-color: #fff;opacity: 1;}',
            '}',
            '</style>',
            '<div class="preloader-loading-more">',
                '<span class="loading-inner">',
                    '<i class="loading-point-1"></i>',
                    '<i class="loading-point-2"></i>',
                    '<i class="loading-point-3"></i>',
                '</span>',
                '正在加载更多',
            '</div>'
        ].join('');

        // 刷新模板
        if ( that.opts.isRefresh ) {
            that.$content.before( refreshTpl );
            that.$pullToRefresh = $('.preloader-refresh');
        }

        // 加载更多模板
        that.$content.after( moveTpl );
        that.$loadingMore = $('.preloader-loading-more');
    };

    /**
     * 事件开始
     */
    Refresh.prototype.bind = function() {
        var that = this,
            timer = null;

        that.$wrap
            .on('touchstart', function(e) {
                that.startY = e.touches[0].pageY;
            })
            .on('touchmove', function(e) {
                that.scrollTop = $(this).scrollTop();

                that.touchMove(e, $(this));
            })
            .on('touchend', function(e) {

                that.touchEnd(e);
            }).
            on('scroll', function() {
                timer = setTimeout(function() {
                    that.getLoadMore( that.$wrap );
                }, 300);
            });


    };

    /**
     * 触摸移动Move
     */
    Refresh.prototype.touchMove = function(e, elem) {
        var that = this,
            currentY = e.touches[0].pageY,
            viewTop = viewHeight + that.scrollTop;
        // viewTop = viewHeight + elem.scrollTop();

        // 设置移动方向
        if ( currentY - that.startY > 0 ) {
            that.opts.movePosition = 'down';
        } else {
            that.opts.movePosition = 'up';
        }

        var distance = currentY - that.startY;

        // 当前处于首屏，50像素容差值 && 向下滑动刷新
        if ( that.scrollTop < that.opts.distanceToRefresh && that.opts.movePosition === 'down'  ) {
            that.$pullToRefresh.show();
            that.isPullToRefresh = true;
            that.$content[0].style[Util.prefixStyle('transform')] = 'translate(0,' + distance + 'px)' + Util.translateZ();
            e.preventDefault();
            return;
        }

        that.isPullToRefresh = false;

    };

    /**
     * 触摸结束
     */
    Refresh.prototype.touchEnd = function(e) {
        var that = this;

        if ( !that.isPullToRefresh ) {
            return;
        }

        /**
         * 回调执行完，回调
         */
        function complete() {
            that.$pullToRefresh.hide();
            that.wrapHeight = that.$content.height();
        }

        // 添加动画事件
        that.$content[0].style[Util.prefixStyle('transition')] = 'all .3s';

        that.$content[0].style[Util.prefixStyle('transform')] = 'translate(0,0)' + Util.translateZ();

        that.$pullToRefresh.show();
        // 回调
        that.opts.refreshCallback && that.opts.refreshCallback(complete);
        that.isPullToRefresh = false;

        setTimeout(function() {
            that.$content[0].style[Util.prefixStyle('transform')] = '';
            that.$content[0].style[Util.prefixStyle('transition')] = '';

        }, 300)
    };

    /**
     * 加载更多
     */
    Refresh.prototype.getLoadMore = function(elem) {
        var that = this,
            scrollTop = elem.scrollTop(),
            viewTop = viewHeight + scrollTop,
            moreTime = null;

        /**
         * 回调执行完，回调
         */
        function complete() {
            that.isLoading = false;
            that.$loadingMore.hide();
            that.wrapHeight = that.$content.height();
        }

        if ( that.wrapHeight <= viewTop  && that.oldScrollTop < scrollTop && !that.isLoading ) {
            that.isLoading = true;

            that.$loadingMore.show();

            that.opts.loadingMoreCallback && that.opts.loadingMoreCallback(complete);
        }

        that.oldScrollTop = scrollTop;

    };

    $.fn.refresh = function( options, callback ) {
        return this.each(function() {
            new Refresh( $(this), options );
        })
    };

}(window, Zepto);
