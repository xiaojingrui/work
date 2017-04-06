/**
 * 封装一些app信息
 * 仅支持7.0.5以后的版本
 */
var Versions = require("common:widget/ui-versions/ui-versions.js");
var ua = window.navigator.userAgent;
var _ready = false;
var _debug = false;
var _init  = false;

var app = {
	events: {},
	listeners: {},
	isIOS : /iPhone|iPad|iPod/i.test(ua),
    isAndroid : /Android/i.test(ua),
    isWinPhone : /Windows\sPhone/i.test(ua),
    init: function(callback, debug){
    	if(_init){
    		//如果已经执行，则直接执行callback
    		callback && callback();
    		return;
    	}
    	this._callback = callback;
    	var self = this;
    	_init = true;
    	_debug = !!debug;

    	// bridge Ready初始化app
		document.addEventListener("hupuBridgeReady", function(){
			self.start.call(self);
		}, false);

    	if((window.HupuBridge && window.HupuBridge.nainfo) || _debug){
    		callback && callback();
    	}
    },
    start: function(){
    	this.bridgeReady();
		if(!_debug){
			this._callback && this._callback();
		}
    },
	bridgeReady: function(){
		if(_ready) return;
		_ready = true;
		var _events = this.events,
			_listeners = this.listeners;

		for(var evt in _events){
			this.registerHandler(evt, _events[evt]);
		}

		for(var item in _listeners){
			this.sendHandler.apply(this, _listeners[item]);
		}
	},
	checkLogin: function(callback, isLogin){
		if(!!isLogin){
			callback();
		} else{
			this.send("hupu.user.login",{}, function(user){
		        if(user){
		            callback(user);
		        }
		    });
		}
	},
	copy: function(content, callback){
		this.send("hupu.ui.copy", {
            content: content
        });
	},
	getVersion: function(defaultVer){
		var defaultInfo = { appVer : defaultVer };
		var nainfo = (window.HupuBridge && HupuBridge.nainfo) ? HupuBridge.nainfo : defaultInfo;
		var appVersion = nainfo.appVer;
		return new Versions(appVersion);
	},
	registerHandler:function(method, callback){
		HupuBridge.register(method, callback);
	},
	register: function(method, callback){
		if(_ready){
			this.registerHandler(method, callback);
		} else{
			this.events[method] = callback;
		}
		this.debug(method);
	},
	sendHandler:function(method, data, successcb, errorcb, sync){
		HupuBridge.send(method, data, successcb, errorcb, sync);
	},
	send: function(method, data, successcb, errorcb, sync){
		successcb = successcb || function(){};
		errorcb = errorcb || function(){};
		data = data || {};
		if(_ready){
			this.sendHandler(method, data, successcb, errorcb, sync);
		} else{
			this.listeners[method] = [method, data, successcb, errorcb, sync];
		}
		this.debug(method, JSON.stringify(data, null, 2));
	},
	debug: function(method, params){
		if(_debug){
			var output = params ? (method + ":\n\r" + params) : method;
			console.log("bridge正在调用 method -> " + output);
		}
	}
}

module.exports = app;
