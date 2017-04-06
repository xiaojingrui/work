var Store = require("common:widget/ui-store/ui-store.js");
var _ = require("underscore");
var _recommendStoreInstance = null;
var recommendPostName = "hupu_bbs_recommend";
var _unlightStore = null;
var unlightMarkName = "hupu_bbs_unlight";
var maxSize = 20;

var BBSStore = {
	init: function(){
		_recommendStoreInstance = new Store(recommendPostName);
		_unlightStore = new Store(unlightMarkName);
		return this;
	},
	havePost: function(tid){
		var allPost = _recommendStoreInstance.get();
			allPost = allPost ? JSON.parse(allPost) : [];
		return _.contains(allPost, tid);
	},
	addPost: function(tid){
		if(this.havePost(tid)) return;
		var allPost = _recommendStoreInstance.get();
			allPost = allPost ? JSON.parse(allPost) : [];
		if(allPost.length >= maxSize){
			allPost.shift();
		}
		allPost.push(tid);
		allPost = JSON.stringify(allPost);
		_recommendStoreInstance.set(allPost);
	},
	hasUnLight: function(){
		var markStatus = _unlightStore.get();
		return !!parseInt(markStatus);
	},
	markUnLight: function(){
		if(this.hasUnLight())return;
		_unlightStore.set(1);
	}
};

var __intance = null;
module.exports = (function(){
	if(!__intance){
		__intance = BBSStore.init();
	}
	return __intance;
})();
