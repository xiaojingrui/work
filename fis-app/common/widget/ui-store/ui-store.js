/**
 * @name 存储类
 * @description 利用本地的存储数据
 */
var UICookies = require("./ui-cookie.js");

var handlers = {
	"LocalStorage": window.localStorage,
	"SessionStorage": window.sessionStorage,
	"Cookie": UICookies
};

var Store = function(name, type){
	this.name = name;
	this.type = type || "LocalStorage";
	this.handler = handlers[this.type];

	this.init();
}
Store.supportLocalStorage = function (){
	return 'localStorage' in window && window['localStorage'] !== null;
}
Store.supportSessionStorage = function (){
	return 'sessionStorage' in window && window['sessionStorage'] !== null;
}
Store.supportCookie = function(){
	return true;
}
Store.prototype = {
	init: function(){
		for(var key in handlers){
			this["isSupport"+ key] = Store["support" + key]();
		}
		return this;
	},
	isSupport: function(type){
		return this["isSupport"+ (type || this.type)];
	},
	get: function(){
		if(this.isSupport()){
			return this.handler.getItem(this.name);
		}
		return "";
	},
	set: function(value){
		if(this.isSupport()){
			return this.handler.setItem(this.name, value);
		}
	},
	remove: function(){
		if(this.isSupport()){
			return this.handler.removeItem(this.name);
		}
	}
}

module.exports = Store;
