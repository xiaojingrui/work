/**
 * @file 列表更多链接
 * @author wangjun@hupu.com
 **/

module.exports = {
    init: function (e, preventAttr) {
        this.listenElement(e, preventAttr);
    },
    /**
     * 监听元素点击的事件. 在标签上添加 data-jump 属性，点击行为被跳转链接.
     * @example
     *    <div data-jump="example">example</div>
     *
     * @param {string} preventAttr 如果点击对象具有该属性则不触发点击跳转 
     **/
    listenElement: function (e, preventAttr) {
        var jumpName = 'data-jump';
        var target = e.target;
        var preventAttr = preventAttr || '';
        if('A' === target.tagName || target.getAttribute(preventAttr)){
            return;
        } else{
            while ( !target.getAttribute(jumpName) ) {
                if (target.tagName === 'BODY') {
                    break;
                } else{
                    target = target.parentElement;
                }
            }
        }
        if ('BODY' !== target.tagName) {
            var jumpLink = target.getAttribute(jumpName);
            window.location = jumpLink;
        }
    }
}