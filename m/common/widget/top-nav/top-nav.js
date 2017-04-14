
    var _ = require('underscore');
    var Util = require('common:widget/ui/util/util.js');
    var Tips = require('common:widget/ui/tips/tips.js');
    var dace = require("common:widget/ui/page-dace/page-dace.js");
    var pageId = __daceDataNameOfPage;

    var win = $(window);

    /**
     * 固定Nav
     * @type {{init: Function, bind: Function}}
     */
    var TopNav = {
        init: function(hasSubNav) {
            var that = this;

            // bbs栏目
            if ( $('#J_topPopBbsNav').length ) {
                PopBbsNav.init();
            }
            this.hasSubNav = hasSubNav;
            this.$nav = $('#J_mTopNav');

            if ( !this.$nav.length ) {
                return;
            }

            this.$topbar = this.$nav.find('.m-top-bar');
            // 按扭查看导航
            this.$buttonAllNav = this.$nav.find('.J_topNavButtonAllNav');
            // 按扭关闭导航
            this.$buttonCloseNav = this.$nav.find('.J_topNavButtonCloseNav');
            this.$oneNav = $('#J_topOneNav');
            this.$buttonSearch = $('.search-link');

            this.$topHeight = this.$topbar.height();
            this.viewHeight = win.height();
            this.oldTop = 0;
            this.isClick = false;

            this.isShow = false;

            this.bind();
        },
        bind: function() {
            var that = this;

            // 显示一级
            this.$buttonAllNav.on('click', function() {
                that.showNav();
                return false;
            });

            //this.$buttonCloseNav.on('click', function() {
            //    that.hideNav();
            //    return false;
            //});

            //是否有二级导航.
            if(this.hasSubNav){
                win
                    // 滚动条
                    .scroll(function() {
                        that.scrollFiexd();
                    });

                $('#J_topMainNav a').on('click', function() {
                    if(that.isClick) {
                        dace.send($(this).attr('dace-node') + '_stick');
                    }
                });
            }

            this.$buttonSearch.on('click', function(e) {
                e.preventDefault();
                if( !HPM.isLogin && HPM.isIndex ){
                    HPM.popLogin();
                }else{
                    location.href = $(this).attr('href');
                }
            })
            //导航字数超过容器显示...
            var clientWidth = document.body.clientWidth;
            var fixedWidth = clientWidth - 225;
            var titleLen1 = $(".m-top-nav .title_len_1");
            var titleWidth = titleLen1.width();

            if(titleWidth >= fixedWidth && titleLen1){
                titleLen1.css({"width":fixedWidth,"overflow":"hidden","text-overflow":"ellipsis","white-space":"nowrap","display":"block"})
            }



        },
        onView: function() {
            var that = this;

            // 关闭
            win.on('touchstart.toponenav', function(e) {

                    if ( !this.isShow && ($(e.target).hasClass('m-one-nav') || $(e.target).parents('.m-one-nav').hasClass('m-one-nav')) ) {
                        return;
                    }

                    that.hideNav();
                })
        },
        offView: function() {
            win.off('touchstart.toponenav');
        },
        /**
         * 显示一级导航
         */
        showNav: function() {
            var that = this;

            if ( this.isShow ) {
                return;
            }

            this.$buttonAllNav.hide();
            this.$buttonCloseNav.show();

            this.$oneNav
                .show()
                .removeClass('topNavInDown')
                .addClass('topNavInDown')
                .cssEnd(function() {
                    that.isShow = true;
                    $(this).removeClass('topNavInDown')
                });

            this.onView();
        },
        hideNav: function() {
            var that = this;

            this.$buttonCloseNav.hide();
            this.$buttonAllNav.show();

            this.$oneNav
                .show()
                .removeClass('topNavInUp')
                .addClass('topNavInUp')
                .cssEnd(function() {
                    that.isShow = false;
                    $(this)
                        .hide()
                        .removeClass('topNavInUp');
                });

            this.offView();
        },
        scrollFiexd: function() {
            var that = this;

            var scrollTop = win.scrollTop(),
                top = 0;

            if(scrollTop >= this.$topHeight){
                top = this.$topHeight;
            } else{
                top = scrollTop;
            }

            if(scrollTop >= this.viewHeight) {
                this.isClick = true;
            }else{
                this.isClick = false;
            }

            if(top == this.oldTop){
                return;
            }
            this.oldTop = top;

            this.$nav[0].style[Util.prefixStyle('transform')] = 'translate(0,-' + top + 'px)' + Util.translateZ();

        }
    }

    /**
     * BBS一级菜单
     * @type {{init: Function}}
     */
    var PopBbsNav = {
        init: function() {

            this.$popup = $('#J_topPopBbsNav');

            this.$tab = this.$popup.find('.J_popBbsNavList');
            this.$list = this.$tab.find('li');
            this.$content = this.$popup.find('.J_popBbsNavContent');

            this.$buttonBbs = $('.J_topNavButtonNavBbs');
            this.activeNumber = 0;
            this.isShow = false;

            this.autoHeight();
            this.bind();
        },
        bind: function() {
            var that = this;

            this.$buttonBbs.on('click', function(e) {

                if ( that.isShow ) {
                    that.hideNav();
                } else {
                    that.showNav();
                }

                return false;
            });

            this.$list.on('click', function() {
                that.activeNumber = $(this).index();
                that.getReply($(this));
            });
        },
        onView: function() {
            var that = this;
            // 关闭
            $('body').on('touchstart.popupbbsnav', function(e) {

                if ( $(e.target).hasClass('button-all-nav') || $(e.target).hasClass('popup-bbs-nav') || $(e.target).parents('.popup-bbs-nav').hasClass('popup-bbs-nav') ) {
                    return;
                }

                that.hideNav();
            })
        },
        offView: function() {

            $('body').off('touchstart.popupbbsnav');
        },
        showNav: function() {
            var that = this;

            if ( this.isShow ) {
                return;
            }

            this.$popup
                .show()
                .removeClass('topNavInLeft')
                .addClass('topNavInLeft')
                .cssEnd(function() {
                    that.isShow = true;
                    $(this).removeClass('topNavInLeft')
                });

            this.onView();
        },
        hideNav: function() {
            var that = this;

            this.$popup
                .removeClass('topNavInRight')
                .addClass('topNavInRight')
                .cssEnd(function() {
                    that.isShow = false;
                    $(this)
                        .hide()
                        .removeClass('topNavInRight');
                });

            this.offView();
        },
        getReply: function(elem) {

            this.$list.removeClass('active');
            elem.addClass('active');

            var tpl = _.template( $("#top-nav-bbs-template").html(), {datas: HPM.bbsNavJson[ this.activeNumber ]} );

            this.$content.html( tpl );
            this.autoHeight();
        },
        /**
         * 自动适应高度
         */
        autoHeight: function() {

            var viewHeight = $(window).height() - $('.m-top-nav').height() - 40;

            this.$popup.css({
                'height' : viewHeight
            });

            this.$tab.css({
               'height' : viewHeight - 2
            });

            this.$content.css({
                'height' : viewHeight - 2
            });
        }
    }

    /**
     * 监听CSS3动画执行结束
     * @param callback
     * @returns {$.fn}
     */
    $.fn.cssEnd = function ( callback ){
        var EventAnimateEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
        this.one(EventAnimateEnd , callback);
        return this;
    };

module.exports = TopNav;
