/**
 * common
 */
!function(win, $){
    // 防止多次加载
    if (typeof win.HP !== "undefined") return false;

    /**
     * 全局 HP 命名空间
     */
    win.HPM = win.HPM || {};

    /**
     * common 命名
     */
    var C = HPM.common = {};

    /**
     * 版本号
     * @type {String}
     */
    C.version = "2.0";

    /**
     * 工具库
     * @type {Object}
     */
    HP.util = {};

    /**
     * UI
     * @type {Object}
     */
    C.ui = {

    }


}(window, Zepto);
