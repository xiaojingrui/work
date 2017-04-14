/**
 * @Description: 下拉到底部和上拉到顶部再拉就出现刷新效果
 * @Author: wangjun
 * @Update: 2015-05-14 16:00
 * @version: 1.0
 * @Github URL: https://github.com/nevergiveup-j/Zepto.refresh
 */
 
"use strict";
var dace = require("common:widget/ui/page-dace/page-dace.js");
var pageId = __daceDataNameOfPage;
var Util = require("common:widget/ui/util/util.js");

// 分享默认配置
var defaults = {
    // 内容ID
    contentEl: '#J_content',
    // 底部ID
    footerEl: "#J_footer",
    // 默认开启刷新
    isRefresh: true,
    // 是否隐藏footer
    hideFooter: false,
    // 下拉可刷新高度
    distanceToRefresh: 50,
    // 下拉阈值
    minDistanceToRefresh: 12,
    // 下拉最大阈值
    maxDistanceToRefresh: 90,
    // 更新限制时间, 默认不限制
    interval : 0,
    // 触摸移动的方向
    movePosition   : null,
    // 完成获取数据文案
    finishText: "您太努力了，都拉到最后一页了",
    // 刷新回调
    refreshCallback: function(complete) {
        window.location.reload();
        complete();
    },
    // 加载更多回调
    loadingMoreCallback: function() {

    }
};

var viewHeight = $(window).height();


function Refresh(options ) {

    this.$wrap = $(window);

    this.opts = $.extend(true, {}, defaults, options || {});

    this.$content = $(this.opts.contentEl);
    this.$footer = $(this.opts.footerEl);

    this.startY = 0;
    this.isPullToRefresh = false;
    this.isLoading = false;
    this.wrapHeight = this.$content.height();
    this.oldScrollTop = 0;
    this.finished = false;
    this.loadingFinishTime = new Date().getTime();

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
        '<div class="preloader-refresh">',
            '<span class="down-arrow"></span>',
            '下拉刷新',
        '</div>'
    ].join('');

    var moveTpl = [
        '<div class="preloader-loading-more">',
            '<span class="top-arrow"></span>',
            '上滑加载更多',
        '</div>'
    ].join('');

    var loadingTpl = [
        '<div class="preloader-loading">',
            '<span class="loading-arrow"></span>',
            '正在加载中，请稍候',
        '</div>'
    ].join('');

    var loadingFinishTpl = '<div class="preloader-finish-loading">#{text}</div>'.replace("#{text}", that.opts.finishText);

    // 刷新模板
    if ( that.opts.isRefresh ) {
        that.$content.before( refreshTpl );
        that.$pullToRefresh = $('.preloader-refresh');
    }

    // 是否隐藏头部
    if ( that.opts.hideFooter ){
        that.$footer.hide();
    }


    // 加载更多模板
    that.$content.after( loadingTpl );
    that.$loading = $('.preloader-loading');

    that.$content.after( moveTpl );
    that.$loadingMore = $('.preloader-loading-more');

    that.$content.after(  loadingFinishTpl );
    that.$loadingFinish = $('.preloader-finish-loading');
};

/**
 * 事件绑定
 */
Refresh.prototype.bind = function() {
    var that = this;

    this.scrollEvent = function() {
        setTimeout(function() {
            that.getLoadMore( that.$wrap );
        }, 300);
    };
    that.$wrap
        .on('touchstart.refreshscroll', function(e) {
            that.startY = e.touches[0].pageY;
            that.startX = e.touches[0].pageX;
        })
        .on('touchmove.refreshscroll', function(e) {
            that.scrollTop = $(this).scrollTop();
            that.touchMove(e, $(this));
        })
        .on('touchend.refreshscroll', function(e) {
            that.touchEnd(e);
        }).
        on('scroll.refreshscroll', this.scrollEvent);
};

/**
 * 事件移除
 */
Refresh.prototype.unbind = function() {

    this.$wrap
        .off('touchstart.refreshscroll')
        .off('touchmove.refreshscroll')
        .off('touchend.refreshscroll');
};

/**
 * 触摸移动Move
 */
Refresh.prototype.touchMove = function(e, elem) {
    var target = $(e.target);
    //如果不是在拖动content, 则不触发.
    if(!target.parents(this.opts.contentEl).size() || !this.opts.isRefresh){
        return;
    }
    var that = this,
        currentY = e.touches[0].pageY,
        currentX = e.touches[0].pageX;

    //如果横向滚动大于纵向滚动. 取消触发事件
    if(Math.abs(currentX - this.startX) > Math.abs(currentY - this.startY)){
        that.isPullToRefresh = false;
        that.$content[0].style[Util.prefixStyle('transform')] = 'translate(0, 0)';
        return;
    }

    // 设置移动方向
    if ( currentY - that.startY > 0 ) {
        that.opts.movePosition = 'down';
    } else {
        that.opts.movePosition = 'up';
    }

    // distance在区间内按正弦分布
    var distance = currentY - that.startY;
        distance = distance < that.opts.maxDistanceToRefresh ? distance : that.opts.maxDistanceToRefresh;
        distance = Math.sin(distance/that.opts.maxDistanceToRefresh) * distance;

    // 当前处于首屏，50像素容差值 && 向下滑动刷新
    if ( that.scrollTop < that.opts.distanceToRefresh && that.opts.movePosition === 'down'  ) {
        that.$pullToRefresh.show();
        that.$content[0].style[Util.prefixStyle('transform')] = 'translate(0,' + distance + 'px)' + Util.translateZ();
        e.preventDefault();
        //未达到下拉阈值，可移除下拉效果.
        if(distance < that.opts.minDistanceToRefresh){
            that.isPullToRefresh = false;
            that.$pullToRefresh.hide();
        } else{
            that.isPullToRefresh = true;
        }
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
    function complete(status) {
        that.$pullToRefresh.hide();

        if("finish" == status){
            that.unbind();
        }

        that.wrapHeight = that.$content.height();
    }

    // 300ms回弹
    setTimeout(function() {
        that.$content[0].style[Util.prefixStyle('transform')] = '';
        that.$content[0].style[Util.prefixStyle('transition')] = '';
    }, 500);

    // 更新refresh 状态
    that.isPullToRefresh = false;

    // 如果存在最大时间限制, 切刷新时间未超出该时间，则不刷新
    var now = new Date().getTime();
    if(that.opts.interval && now - that.loadingFinishTime < that.opts.interval){
        complete();
        return;
    }
    that.loadingFinishTime = now;

    // 添加动画事件
    that.$content[0].style[Util.prefixStyle('transition')] = 'all .3s';

    that.$content[0].style[Util.prefixStyle('transform')] = 'translate(0,0)' + Util.translateZ();

    that.$pullToRefresh.show();
    // 回调
    that.opts.refreshCallback && that.opts.refreshCallback.call(this, complete);
    
};

/**
 * 加载更多
 */
Refresh.prototype.getLoadMore = function(elem) {
    if(this.finished){
        return;
    }
    var that = this,
        scrollTop = elem.scrollTop(),
        viewTop = viewHeight + scrollTop,
        moreTime = null;

    /**
     * 回调执行完，回调
     */
    function complete(status) {
        that.isLoading = false;
        that.$loading.hide();
        if("finish" == status){
            that.finished = true;
            that.$loadingMore.hide();
            that.$wrap.off("scroll.refreshscroll");
            that.$loadingFinish.show();
            if(that.opts.hideFooter) that.$footer.show();
        } else{
            that.$loadingMore.show();
        }
        that.wrapHeight = that.$content.height();
    }

    if ( that.wrapHeight <= viewTop + 10  && that.oldScrollTop < scrollTop && !that.isLoading ) {
        // 如果存在最大时间限制, 切刷新时间未超出该时间，则不刷新
        var now = new Date().getTime();
        if(that.opts.interval && now - that.loadingFinishTime < that.opts.interval){
            return;
        }
        that.loadingFinishTime = now;

        // loading状态更新
        that.isLoading = true;
        that.$loading.show();
        that.$loadingMore.hide();

        dace.send(pageId + "_slide");
        that.opts.loadingMoreCallback && that.opts.loadingMoreCallback.call(this, complete);
    }

    that.oldScrollTop = scrollTop;

};
/**
 *  @param contentEl {string}, 内容容器ID, 默认'#J_content'
 *  @param footerEl {string}, 底部容器ID, 默认"#J_footer"
 *  @param isRefresh {boolean}, 刷新开关, 默认开启
 *  @param hideFooter {boolean}, 隐藏底部开干, 默认关闭
 *  @param distanceToRefresh {number},下拉可刷新高度，默认50,
 *  @param minDistanceToRefresh {number}, 下拉最小阈值, 默认 12
 *  @param maxDistanceToRefresh {number}, 下拉最大阈值, 默认90
 *  @param interval {number} 单位ms,更新限制时间, 默认不限制
 *  @param movePosition 触摸移动的方向
 *  @param finishText {string}, 完成获取数据文案, 默认"您太努力了，都拉到最后一页了",
 *  @param refreshCallback {function}, 刷新回调
 *  @param loadingMoreCallback {function},加载更多回调
 *
 ***/
module.exports = function(options) {
    return new Refresh(options);
};

