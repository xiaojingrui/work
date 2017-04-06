/**
 * @file 封装dace接口
 * @author yuhongfei@hupu.com
 **/
import $ from './zepto'
import _ from 'underscore'

let _queue = [];
let maxCache = 20;

const daceSingle = {
    init: function() {
        this.listenElement();
        this.listenDace();
    },
	/**
	 * 监听元素点击的事件. 在标签上添加 dace-node 属性，点击行为被自动收集.
	 * @example
	 *    <div dace-node="example">example</div>
	 **/
    listenElement:  function(){
        let hasTouch = 'ontouchstart' in window;
        let nodeName = 'dace-node';
        let send = this.send;

        $('body').on(hasTouch ? 'click' : 'mousedown',  (e) => {
            let target = e.target;
            while (!target.getAttribute(nodeName) && 'BODY' !== target.tagName) {
                target = target.parentElement;
                if (!target) {
                    break;
                }
            }
            if (_.isElement(target) && 'BODY"' !== target.tagName) {
                let daceData = target.getAttribute(nodeName);
                send(daceData);
            }
        });
    },
	/**
	 * 监听dace是否ready
	 **/
    listenDace: function() {
        this.interval = setInterval( () => {
            if (window.__dace && window.__dace.sendEvent) {
                clearInterval(this.interval);
                if (_queue && _queue.length) {
                    this.send();
                }
            }
        }, 5000);
    },
    /**
	 * 做个简单的队列，避免丢失统计数据.
	 *
	 * @param {string} daceStr dace的数据
	 * @return {void}
	 */
     send: function( daceStr ) {
		if(window.__dace){
			let sendHandler = window.__dace.sendEvent;
			if(daceStr && daceStr.length) sendHandler(daceStr);
			if(_queue && _queue.length){
				_.each(_queue, function(item){
					sendHandler(item);
				});
				_queue = [];
			}
		} else{
			if(daceStr && daceStr.length) {
				if(_queue.length >= maxCache){
					_queue.shift();
				}
				_queue.push(daceStr);
			}
		}
	}
}

module.exports = daceSingle
