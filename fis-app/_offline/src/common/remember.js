import Store from './store'
import $ from './zepto'
import _ from 'underscore'

let rememberPos = {
	init(container, hash, savekey = "remember_store" ) {
        this.storeInstance = new Store(`hupu_${savekey}`)
        this.hash = `n${hash}`
        this.count = 0
        this.container = $(container)

		let imgs = this.container.find("img"),
            self = this,
            maxLen = imgs.size(),
            map = this.get();

        if(map && map[this.hash] && map[this.hash] > 0){
            let scrollTop = map[this.hash]
            if(maxLen > 0){
                //页面图片全部加载完毕才能开始滚动.
        		imgs.each((idx, img) => {
        			// 图片缓存
        			if(img.complete){
        				self.imagesLoaded(maxLen, scrollTop)
        			} else{
        				img.onload = img.onerror = function(){
        					self.imagesLoaded(maxLen, scrollTop)
                            img.onload = img.onerror = null
        				}
        			}
        		});
            } else{
                this.imagesLoaded(maxLen, scrollTop)
            }
        } else{
            this.startListenRemember()
        }

	},
    //图片加载完毕，开始滚动到指定位置
    imagesLoaded( max, top ){
        this.count++
        if(this.count >= max){
            // 兼容安卓不支持scrollTop的方法
            setTimeout(() => {
                let gotoTop = top || 0
                $(window).scrollTop(gotoTop)
                this.startListenRemember()
            }, 500);
        }
    },
    //开始记录
    startListenRemember(){
        let interval,
            self = this

        $(window).on("scroll", function(){
			clearTimeout(interval);
			interval = setTimeout(function() {
				let scrollTop = $(this).scrollTop()
                let offset = self.container.offset()
                let maxTop = offset.top + offset.height
				self.save(Math.min(scrollTop, maxTop))
			}, 200);
		});
    },
    //写入本地
    save(top){
        let map = this.get()
        map[this.hash] = top
        this.storeInstance.setValue(JSON.stringify(map))
    },
    //获得全部本地数据
    get(){
        let json = this.storeInstance.getValue()
        let ret = null
        if(_.isString(json)){
            ret = JSON.parse(json)
        } else if(_.isArray(json) && _.isObject(json)){
            ret = json
        }
        return ret || {}
    }
}

export default rememberPos
