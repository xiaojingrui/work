/**
 * @file 分享调用
 * @author yuhongfei@hupu.com
 * @date 2015-05-20
 * @desc 保持分享的唯一实例
 */
"use strict";
//分享实例. 单页唯一.
var Instance = null;
var IsShareOpen = false;

// 分享默认配置
var defaults = {
	social:["weibo", "qzone"],
	shareConfig: {
		// 标题
    	title: document.title,
    	// 链接
    	url: window.location.href,
    	// 图片路径，使用多张图片以||隔开[a.jpg||b.jpg] bug 多张不一样
    	pic: '',
    	// 分享摘要
    	summary: '',
    	// 分享理由 (QQ)
    	desc: '',
    	// 自动抓取页面上的图片 (新浪微博)
    	searchPic: true,
    	// 分享来源
    	source: {
    		appkey: {
	    		weibo: '2175967801',
	    		tqq: 'abe3b0bfec0044ea852fbf1456497950'
	    	},
	    	ralateUid: {
	    		weibo: '1642292081',
	    		tqq: '@the_real_hoopchina'
	    	},
	    	// 分享来源 (QQ空间、QQ)
	    	siteName: '虎扑体育'
    	}
	},
	// 设置按扭
	buttons: {
		'weibo': {
			text: '新浪微博', 
			url: 'http://service.weibo.com/share/share.php?url={url}&title={title}&pic={pic}&appkey={appkey}&ralateUid={ralateUid}&searchPic={searchPic}'
		},
    	'qzone': {
    		text: 'QQ空间', 
    		url: 'http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={url}&title={title}&pics={pic}&summary={summary}&site={site}'
    	},
    	'qq': {
    		text: 'QQ', 
    		url: 'http://connect.qq.com/widget/shareqq/index.html?url={url}&title={title}&pics={pic}&summary={summary}&desc={desc}&site={site}'
    	},
    	'tqq': {
    		text: '腾讯微博', 
    		className: 'tqq', 
    		url: 'http://v.t.qq.com/share/share.php?url={url}&title={title}&pic={pic}&appkey={appkey}'
    	}
	}
}

/**
 * 分享API
 * @param  {string}  site        类型(*必写)
 * @param  {object}  options     分享配置
 * @config {string}  [title]     可选，分享标题
 * @config {string}  [url]       可选，分享链接
 * @config {string}  [pic]       可选，分享图片的路径。使用多张图片以||隔开[a.jpg||b.jpg] bug 多张不一样
 * @config {string}  [summary]   可选，分享摘要
 */
var getShareAPI = function( site, options ) {

	// 分享配置
	var config = defaults.shareConfig;
		config.buttons = defaults.buttons;

	var opts = $.extend(true,{}, config, options || {}),
		title = encodeURIComponent( opts.title ),
		url = encodeURIComponent( opts.url ),
		pic = opts.pic,
		summary = encodeURIComponent( opts.summary ),
		desc = encodeURIComponent( opts.desc ),
		sites = encodeURIComponent( opts.source.site ),
		appkey = Converted( opts.source.appkey.weibo, opts.source.appkey.tqq ),
		ralateUid = Converted( opts.source.ralateUid.weibo, opts.source.ralateUid.tqq );


	// 无分享类型
	if ( typeof opts.buttons[ site ] === "undefined" ) {
		return;
	};

	// 新浪微博分享使用多张图片路径
	var piaArray = pic.split('||');

	if ( piaArray.length > 1 && site !== 'weibo' ) {
		pic = piaArray[0];
	};

	pic = encodeURIComponent( pic );


	// 类型appkey
	function Converted( weibo, tqq ) {
		var newAppkey = '';

		if ( site === 'tqq' ) {
			newAppkey = tqq;
		} else {
			newAppkey = weibo;
		}

		return newAppkey;
	}

	var sitesURL = opts.buttons[ site ]['url'].replace('{url}', url).replace('{title}', title)
											  .replace('{pic}', pic).replace('{appkey}', appkey)
											  .replace('{ralateUid}', opts.ralateUid).replace('{summary}', summary)
											  .replace('{site}', sites).replace('{desc}', desc)
											  .replace('{searchPic}', opts.searchPic);

	
	return sitesURL;
};

/**
 * 分享类
 * @param  {object}  options     分享配置
 * @options {string}  [title]     可选，分享标题
 * @options {string}  [url]       可选，分享链接
 * @options {string}  [pic]       可选，分享图片的路径。使用多张图片以||隔开[a.jpg||b.jpg] bug 多张不一样
 * @options {string}  [summary]   可选，分享摘要
 ***/
function Share(options ) {
	this.merge(options);
};

Share.prototype = {
	merge: function(options){
		this.config = $.extend(true,{}, defaults, options || {});
		this.init();
	},
	init: function() {
		if(document.getElementById('J-share-global')){
			this.show();
			return;
		}
		this.render();
		this.show();
		this.bindEvent();
	},
	render: function() {
		this.$elem = $("<div />").attr("id", "J-share-global").addClass("hp-share-container");
		this.$mask = $("<div />").addClass('hp-share-mask');
		$("body").append( this.$mask );
		$("body").append( this.$elem );
	},
	bindEvent: function() {
		var config = this.config;
		var self = this;

		this.$elem.bind('click', function(e) {
			self.hide();
		});

		$(window).bind('resize', function(e) {
			if(IsShareOpen){
				self.show();
			}
		});
	},
	show: function(){
		IsShareOpen = true;
		var self = this;
		var socials = this.config.social;
		var title = this.config.title;

		var width = $(window).width();
		var height = $(window).height();
		var docHeight = $(document).height();
		var scrollTop = $(window).scrollTop();


		this.$elem.css({
			"width": width,
			"height": docHeight
		});
		this.$mask.css({
			"width": width,
			"height": docHeight
		});

		var pageId = __daceDataNameOfPage;
		var html = "";
		html += "<ul>";
		socials.forEach(function(social){
			var url = getShareAPI(social, self.config);
			html += '<li dace-node="'+ pageId + '_share_' + social +'"><a href="'+ url +'" target="_blank" class="btn-share btn-share-'+ social +'"></a></li>';
		});
		html += "</ul>";

		this.$elem.empty().html(html);
		var $iconWarp = this.$elem.find("ul");
		$iconWarp.css("margin-top", scrollTop + height * 0.5 - 25);

		//模糊页面，影响 nav, header, footer, m-row.
		$("body").addClass("blur-body");

		//PC上可行的禁止滚动方法.
		$("html").addClass("hide-body-scroll");
		//兼容手机分享无法滚屏的bug.
		this.$elem.on("touchmove.sharemark",function(e){  
            e.stopPropagation();
            e.preventDefault();
        });

		this.$mask.show();
		this.$elem.show();
	},
	hide: function(){
		IsShareOpen = false;
		$("html").removeClass("hide-body-scroll");
		$("body").removeClass("blur-body");
		this.$elem.off(".sharemark");

		this.$mask.hide();
		this.$elem.hide();
	}
};

module.exports = function(options){
	if(Instance){
		return Instance.merge(options);
	} else{
		return Instance = new Share(options);
	}	
}