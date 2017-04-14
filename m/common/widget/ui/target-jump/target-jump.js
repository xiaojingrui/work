/**
 * @file 列表更多链接
 * @author wangjun@hupu.com
 **/

module.exports = {
    init: function (e) {
        this.listenElement(e);
    },
	/**
	 * 监听元素点击的事件. 在标签上添加 data-jump 属性，点击行为被跳转链接.
	 * @example
	 *    <div data-jump="example">example</div>
	 **/
    listenElement: function (e) {
        var jumpName = 'data-jump';
        var target = e.target;
        if('A' === target.tagName){
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