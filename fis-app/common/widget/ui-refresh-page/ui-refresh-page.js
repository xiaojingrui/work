/**
 * @Description: 下拉到底部和上拉到顶部再拉就出现刷新效果
 * @Author: wangjun
 * @Update: 2015-10-13 13:27
 * @version: 1.1
 * @Github URL: https://github.com/nevergiveup-j/Zepto.refresh
 */
var Util = require("common:widget/ui-tools/ui-tools.js");

// 分享默认配置
var defaults = {
    // 内容ID
    contentEl: '#J_content',
    // 默认开启刷新
    isRefresh: true,
    // 是否最后一页
    isLast: false,
    // 默认开启加载更多
    isLoadingMore: true,
    // 触摸移动的方向
    movePosition: null,
    // 下拉最小阈值
    minDistanceToRefresh: 50,
    // 下拉最大阈值
    maxDistanceToRefresh: 100,
    // 更新限制时间, 默认不限制
    interval: 5,
    // 刷新回调
    refreshCallback: function() {

    },
    // 加载更多回调
    loadingMoreCallback: function() {

    }
};

var viewHeight = $(window).height();


function Refresh(options) {

    this.$wrap = $(window);

    this.opts = $.extend(true, {}, defaults, options || {});

    this.$content = $(this.opts.contentEl);
    this.touchLockStatus = false;
    this.startY = 0;
    this.refreshHeight = 50;
    this.isPullToRefresh = false;
    this.isPushToRefresh = false;
    this.isLoading = false;
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
    this.loadingRender();

    this.bind();
};

Refresh.prototype.touchLock = function(){
    this.touchLockStatus = true;
}

Refresh.prototype.touchUnLock = function(){
    this.touchLockStatus = false;
}

/**
 * loading加载
 */
Refresh.prototype.loadingRender = function() {
    var that = this;

    var refreshTpl = [
        '<div class="preloader-refresh">',
        '下滑加载上一页',
        '</div>'
    ].join('');


    var moveTpl = [
        '<div class="preloader-loading-more">',
        (this.opts.isLast ? '':'上拉加载下一页'),
        '</div>'
    ].join('');

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
    }
};
/**
 * update
 */
Refresh.prototype.update = function(isLast) {
    this.$loadingMore.text(isLast ? '' : '上拉加载下一页');
    
};

/**
 * 事件
 */
Refresh.prototype.bind = function() {
    var that = this,
        timer = null;

    // 未开启刷新不添加事件
    if (this.opts.isRefresh) {
        this.$wrap
            .on('touchstart', function(e) {
                if(that.touchLockStatus) return;
                that.startX = e.touches[0].pageX;
                that.startY = e.touches[0].pageY;
            })
            .on('touchmove', function(e) {
                that.scrollTop = $(this).scrollTop();

                that.touchMove(e, $(this));
            })
            .on('touchend', function(e) {
                that.touchEnd(e);
            });
    }

};

/**
 * 触摸移动Move
 */
Refresh.prototype.touchMove = function(e, elem) {
    if(this.touchLockStatus) return;
    var target = $(e.target);
    //如果不是在拖动content, 则不触发.
    if (!target.parents(this.opts.contentEl).size()) {
        return;
    }

    var currentX = e.touches[0].pageX - this.startX,
        currentY = e.touches[0].pageY - this.startY;

    // 如果横向滚动大于纵向滚动. 取消触发事件
    if (Math.abs(currentX) > Math.abs(currentY)) {
        this.isPullToRefresh = false;
        this.isPushToRefresh = false;
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

    var offsetTop = this.$content.offset().top;
    // distance在区间内按正弦分布
    var distance = currentY;
    distance = distance < this.opts.maxDistanceToRefresh ? distance : this.opts.maxDistanceToRefresh;
    distance = Math.sin(distance / this.opts.maxDistanceToRefresh) * distance;
    // 当前处于首屏，50像素容差值 && 向下滑动刷新
    if (this.scrollTop === 0 && this.opts.movePosition === 'down' && offsetTop < 100) { 
        if (currentY >= this.opts.minDistanceToRefresh) {
            this.isPullToRefresh = true;
        } else {
            this.isPullToRefresh = false;
        }

        this.$content[0].style[Util.prefixStyle('transform')] = 'translate(0,' + distance + 'px)' + Util.translateZ();
        this.$pullToRefresh[0].style[Util.prefixStyle('transform')] = 'translate(0,' + distance + 'px)' + Util.translateZ();
        e.preventDefault();
        return;
    } else{
        distance = distance < this.opts.maxDistanceToRefresh ? distance : this.opts.maxDistanceToRefresh;
        distance = Math.sin(distance / this.opts.maxDistanceToRefresh) * distance;
        var maxScrollHeight = $(document).height() - $(window).height();// - this.opts.minDistanceToRefresh;
         // 当前大于像素容差值 && 拉上滑动
        if (this.scrollTop >= maxScrollHeight  && this.opts.movePosition === 'up') {

            if (Math.abs(currentY) >= this.opts.minDistanceToRefresh) {
                this.isPushToRefresh = true;
            } else {
                this.isPushToRefresh = false;
            }

            this.$content[0].style[Util.prefixStyle('transform')] = 'translate(0,-' + distance + 'px)' + Util.translateZ();
            e.preventDefault();
            return;
        }
    }

    this.isPullToRefresh = false;
    this.isPushToRefresh = false;

};

/**
 * 触摸结束
 */
Refresh.prototype.touchEnd = function(e) {
    if(this.touchLockStatus) return;
    var that = this;

    /**
     * 回调执行完，回调
     */
    function complete(status) {
        that.$loadingMore.text(status == "finish" ? "" : "上拉加载下一页");
        that.wrapHeight = that.$content.height();
        that.$content[0].style[Util.prefixStyle('transition')] = 'all .3s';
        that.$content[0].style[Util.prefixStyle('transform')] = 'translate(0, 0)' + Util.translateZ();
        that.$pullToRefresh[0].style[Util.prefixStyle('transition')] = 'all .3s';
        that.$pullToRefresh[0].style[Util.prefixStyle('transform')] = 'translate(0, 0)' + Util.translateZ();
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
        this.opts.refreshCallback && this.opts.refreshCallback(complete);
        // 更新refresh 状态
        this.isPullToRefresh = false;
    }

    /**
     * 上拉回调
     */
    function pushComplete(status) {
        if ("finish" == status) {
            that.$loadingMore.text("");
        }
    }

    // 回调
    if (this.isPushToRefresh) {
        // 更新refresh 状态
        this.isPushToRefresh = false;

        this.opts.loadingMoreCallback && this.opts.loadingMoreCallback(pushComplete);
        
    }


};

module.exports = function(options) {
    return new Refresh(options);
};