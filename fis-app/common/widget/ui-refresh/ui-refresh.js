/**
 * @Description: 下拉到底部和上拉到顶部再拉就出现刷新效果
 * @Author: wangjun
 * @Update: 2015-10-13 13:27
 * @version: 1.1
 * @Github URL: https://github.com/nevergiveup-j/Zepto.refresh
 */
var Util = require("common:widget/ui-tools/ui-tools.js");
var app = require("common:widget/ui-app/ui-app.js");
var version = require("common:widget/ui-versions/ui-versions.js");
// 分享默认配置
var defaults = {
    // 内容ID
    contentEl: '#J_content',
    // 默认开启刷新
    isRefresh: true,
    // 默认开启加载更多
    isLoadingMore: true,
    // 触摸移动的方向
    movePosition: null,
    // 下拉可刷新高度
    distanceToRefresh: 50,
    // 下拉最小阈值
    minDistanceToRefresh: 50,
    // 下拉最大阈值
    maxDistanceToRefresh: 100,
    // 更新限制时间, 默认不限制
    interval: 5,
    loadingStyle: 1,
    // 刷新回调
    refreshCallback: function() {

    },
    // 加载更多回调
    loadingMoreCallback: function() {

    }
};

var viewHeight = $(window).height();
var isAndroid = /android/i.test( navigator.userAgent.toLowerCase() ) || /Linux/i.test( navigator.userAgent.toLowerCase() );

// android 4.3以下window高度问题
if(isAndroid) {
    var screenHeight = window.screen.height - 100;
    viewHeight = Math.max(viewHeight, screenHeight);
}

function Refresh(options) {

    this.$wrap = $(window);

    this.opts = $.extend(true, {}, defaults, options || {});

    this.$content = $(this.opts.contentEl);

    this.startY = 0;
    this.refreshHeight = 0;
    this.isPullToRefresh = false;
    this.isLoading = false;
    this.finished = false;
    this.wrapHeight = this.$content.height();
    this.oldScrollTop = 0;
    this.loadingFinishTime = new Date().getTime();

    this.scrollTop = this.$content.scrollTop();

    this.init();
};


/**
 * 初始化
 */
Refresh.prototype.init = function() {
    var that = this;

    this.loadingRender();

    this.bind();
    this.reBindScroll();
};

/**
 * loading加载
 */
Refresh.prototype.loadingRender = function() {
    var that = this;

    // android QQ浏览器新闻闪动
    if(version.lte(GM.version,"7.0.6") && app.isAndroid){
        var refreshTpl = [
            '<div class="preloader-refresh">',
                '<div class="refresh-text">下拉刷新</div>',
            '</div>'
        ].join('');

        var moveTpl = [
            '<div class="preloader-loading-more preloader-loading-more2">',
                '加载中…',
            '</div>'
        ].join('');
    }else{
        var refreshTpl = [
            '<div class="preloader-refresh">',
                '<i class="icon-refresh"></i>',
            '</div>'
        ].join('');

        var moveTpl = [
            '<div class="preloader-loading-more preloader-loading-more1">',
                '<span class="loading-bounce"></span>',
            '</div>'
        ].join('');
    }

    // 刷新模板
    if (this.opts.isRefresh) {
        this.$content.before(refreshTpl);
        this.$pullToRefresh = $('.preloader-refresh');
        this.refreshHeight = this.$pullToRefresh.height();
    }

    // 加载更多模板
    if (this.opts.isLoadingMore) {
        this.$content.after(moveTpl);
        this.$loadingMore = $('.preloader-loading-more');

        if(this.wrapHeight < viewHeight){
            this.$loadingMore.hide();
        }
    }
};

/**
 * 事件
 */
Refresh.prototype.bind = function() {
    var that = this;

    // 未开启刷新不添加事件
    if (this.opts.isRefresh) {
        this.$wrap
            .on('touchstart', function (e) {
                that.startX = e.touches[0].pageX;
                that.startY = e.touches[0].pageY;
            })
            .on('touchmove', function (e) {
                that.scrollTop = $(this).scrollTop();

                that.touchMove(e, $(this));
            })
            .on('touchend', function (e) {
                that.touchEnd(e);
            });
    }

    // 注册加载更多事件
    $(window)
        .on("loadMoreCallback", function(event, status) {
            that.loadMoreCallback(status);
        });

};

/**
 * 事件
 */
Refresh.prototype.reBindScroll = function() {
    var that = this,
        timer = null;

    this.$wrap
        .off('scroll.refresh')
        .on('scroll.refresh', function() {
            timer = setTimeout(function() {
                that.getLoadMore();
            }, 300);
        });
};

/**
 * 触摸移动Move
 */
Refresh.prototype.touchMove = function(e, elem) {
    var target = $(e.target);
    //如果不是在拖动content和, 则不触发.
    if (!target.parents(this.opts.contentEl).size()) {
        return;
    }

    var currentX = e.touches[0].pageX - this.startX,
        currentY = e.touches[0].pageY - this.startY;

    // 如果横向滚动大于纵向滚动. 取消触发事件
    if (Math.abs(currentX) > Math.abs(currentY)) {
        this.isPullToRefresh = false;
        this.$content[0].style[Util.prefixStyle('transform')] = 'translate(0, 0)' + Util.translateZ();
        this.$pullToRefresh[0].style[Util.prefixStyle('transform')] = 'translate(0, 0)' + Util.translateZ();
        return;
    }

    // 设置移动方向
    if (currentY > 0) {
        this.opts.movePosition = 'down';
    } else {
        this.opts.movePosition = 'up';
    }

    // distance在区间内按正弦分布
    var distance = currentY;
    distance = distance < this.opts.maxDistanceToRefresh ? distance : this.opts.maxDistanceToRefresh;
    distance = Math.sin(distance / this.opts.maxDistanceToRefresh) * distance;


    // 当前处于首屏，设置distanceToRefresh坐标 && 向下滑动刷新
    if (this.scrollTop <= this.opts.distanceToRefresh && this.opts.movePosition === 'down') {
        //
        if (currentY >= this.opts.minDistanceToRefresh) {
            this.$pullToRefresh.addClass('preloader-refresh-flip');
            this.isPullToRefresh = true;
        } else {
            this.$pullToRefresh.removeClass('preloader-refresh-flip');
            this.isPullToRefresh = false;
        }

        this.$content[0].style[Util.prefixStyle('transform')] = 'translate(0,' + distance + 'px)' + Util.translateZ();
        this.$pullToRefresh[0].style[Util.prefixStyle('transform')] = 'translate(0,' + distance + 'px)' + Util.translateZ();
        e.preventDefault();
        return;
    }

    this.isPullToRefresh = false;

};

/**
 * 触摸结束
 */
Refresh.prototype.touchEnd = function(e) {
    var that = this;

    /**
     * 回调执行完，回调
     */
    function complete() {
        that.$pullToRefresh.removeClass('preloader-refresh-loading');
        // android QQ浏览器新闻闪动
        if(version.lte(GM.version,"7.0.6") && app.isAndroid){
            that.$pullToRefresh.find('.refresh-text').html('下拉刷新');
        }

        that.wrapHeight = that.$content.height();
        that.$content[0].style[Util.prefixStyle('transition')] = 'all .3s';
        that.$content[0].style[Util.prefixStyle('transform')] = 'translate(0, 0)' + Util.translateZ();
        that.$pullToRefresh[0].style[Util.prefixStyle('transition')] = 'all .3s';
        that.$pullToRefresh[0].style[Util.prefixStyle('transform')] = 'translate(0, 0)' + Util.translateZ();

        // 下拉加载到最后一页，异步刷新重新开始scroll事件
        if(that.finished){
            that.finished = false;
            that.reBindScroll();
        }
        clearStyle();
    };

    // 清除样式
    function clearStyle() {
        // 500ms回弹
        setTimeout(function() {
            that.$content[0].style[Util.prefixStyle('transition')] = '';
            that.$pullToRefresh[0].style[Util.prefixStyle('transition')] = '';
        }, 500);
    };

    clearStyle();

    // 如果存在最大时间限制, 切刷新时间未超出该时间，则不刷新
    var now = new Date().getTime();

    if (this.opts.interval && now - this.loadingFinishTime < this.opts.interval) {
        complete();
        return;
    }

    this.loadingFinishTime = now;

    var distance = 0;

    // 向下滑动距离最小阈值
    if (this.isPullToRefresh) {
        distance = this.refreshHeight;
    }

    // 添加动画事件
    this.$content[0].style[Util.prefixStyle('transition')] = 'all .3s';
    this.$content[0].style[Util.prefixStyle('transform')] = 'translate(0, ' + distance + 'px)' + Util.translateZ();
    this.$pullToRefresh[0].style[Util.prefixStyle('transition')] = 'all .3s';
    this.$pullToRefresh[0].style[Util.prefixStyle('transform')] = 'translate(0,' + distance + 'px)' + Util.translateZ();

    // 回调
    if (this.isPullToRefresh) {
        this.$pullToRefresh
            .removeClass('preloader-refresh-flip')
            .addClass('preloader-refresh-loading');

        // android QQ浏览器新闻闪动
        if(version.lte(GM.version,"7.0.6") && app.isAndroid){
            this.$pullToRefresh.find('.refresh-text').html('正在刷新');
        }
        this.opts.refreshCallback && this.opts.refreshCallback(complete);
        // 更新refresh 状态
        this.isPullToRefresh = false;
    }

};

/**
 * 加载更多
 */
Refresh.prototype.getLoadMore = function() {
    if(this.finished){
        return;
    }

    var that = this,
        scrollTop = this.$wrap.scrollTop(),
        viewTop = viewHeight + scrollTop,
        moreTime = null;

    /**
     * 回调执行完，回调
     */
    function complete(status) {
        that.loadMoreCallback(status);
    }
    if (this.wrapHeight <= viewTop + 10 && this.oldScrollTop < scrollTop && !this.isLoading && this.opts.isLoadingMore) {
        // 如果存在最大时间限制, 切刷新时间未超出该时间，则不刷新
        var now = new Date().getTime();
        if (this.opts.interval && now - this.loadingFinishTime < this.opts.interval) {
            return;
        }
        this.loadingFinishTime = now;

        this.$loadingMore.show();
        // loading状态更新
        this.isLoading = true;

        this.opts.loadingMoreCallback && this.opts.loadingMoreCallback(complete);
    }
    this.oldScrollTop = scrollTop;
};

/**
 * 加载更多
 */
Refresh.prototype.loadMoreCallback = function(status) {
    if ("finish" == status) {
        this.finished = true;
        this.$loadingMore.hide();
        this.$wrap.off("scroll.refresh");
    }
    this.isLoading = false;
}

/**
 * 更新高度  修复IOS下新闻评论删除 封禁后无法滚动加载问题
 */
Refresh.prototype.uploadWrapHeight = function() {
    this.wrapHeight = this.$content.height();
}

module.exports = function(options) {
    return new Refresh(options);
};
