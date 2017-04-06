/**
 * @name AJAX异步缓存类
 * @author yuhongfei@hupu.com
 * @description AJAX异步缓存类
 * @return {object}
 * 
 ****/

/**
 * @name 内部类-缓存类
 * @return {object}
 */
var __Cache = function(){
	this.data = {};
}
__Cache.prototype = {
	get:function(key){
		return this.data[key];
	},
	set: function(key, value){
		this.data[key] = value;
	},
	vailKey: function(key){
		return !!this.data[key];
	}
};

/**
 * @name 对外接口
 * @description 对AJAX简单封装
 * 
 */
var Load = function(){
	this.cache = new __Cache();
}

Load.prototype ={
	pending: function(option, callback, errCallback){
		var mott = $.extend({}, option.data);
			mott.url = option.url;
			mott.type = option.type;

		var cacheKey = this.hashKey(mott);
		var self = this;

		if(this.cache.vailKey(cacheKey)){
			var data = this.cache.get(cacheKey);
			callback(data);
		} else{
			$.ajax({
	            url: option.url,
	            type: option.type,
	            dataType: option.dataType || "json",
	            data: option.data,
	            timeout: option.timeout || 30000,
	            success: function(res){
	            	if(!option.noCache){
	            		self.cache.set(cacheKey, res);
	            	}
	            	callback && callback(res);
	            },
	            error: function(err){
	            	errCallback && errCallback(err);
	            }
	        });
		}
	},
	hashKey: function(param){
		var key = "";
		for(var i in param){
			key += i + "=" + param[i];
		}
		key = key.replace(/=/g,"_")
				 .replace(/\//g,"_");
		return key;
	}
}

var __intance = null;
module.exports = (function(){
	if(!__intance){
		__intance = new Load();
	}
	return __intance;
})();