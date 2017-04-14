/**
 * @file 整站都会引用的js，整站js的入口文件
 * @author yuhongfei@hupu.com
 **/
(function (win) {
    var pageDace = require('common:widget/ui/page-dace/page-dace.js');
    var targetJump = require('common:widget/ui/target-jump/target-jump.js');
    var pageTools = require('common:widget/ui/page-tools/page-tools.js');
    var SectionExposure = require("common:widget/ui/section-exposure/section-exposure.js");

    /**
     * 获取url参数
     * @param name
     * @returns {string}
     */
    function getQueryString(name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }

    $(document).ready(function () {
        var hasTouch = 'ontouchstart' in window;

        $('body').on(hasTouch ? 'click' : 'mousedown', function (e) {
            //统计初始化.
            pageDace.init(e);

            // 列表跳转链接
            targetJump.init(e);
        });

        // 栏目爆光初始化
        SectionExposure.init();

        // 贴吧去掉返回顶部
        if ( getQueryString('m_from') !== 'tieba' ) {
            //返回顶部
            pageTools.init();
        }
    });

})(window);