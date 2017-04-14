var win = $(window);

/**
 * 固定Nav
 * @type {{init: Function, bind: Function}}
 */
module.exports = {
    init: function() {
        var that = this;

        this.$nav = $('#J_fixednavTab');

        if (!this.$nav.length) {
            return;
        }

        this.navTop = this.$nav.offset().top;

        this.bind();
    },
    bind: function() {
        var that = this,
            timer = null;

        win.scroll(function() {
            timer = setTimeout(function() {
                that.scrollBind();
            }, 100);
        });
    },
    scrollBind: function() {
        var that = this;

        var scrollTop = win.scrollTop();


        if (scrollTop >= that.navTop) {
            that.$nav.addClass('nav-tab-fixed');
        } else {
            that.$nav.removeClass('nav-tab-fixed');
        }
    }
}