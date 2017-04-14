/**
 * @file 页面翻页js组件
 * @author yuhongfei@hupu.com
 * @date 2015-06-02
 */
"use strict";
var _ = require("underscore");
var util = require("common:widget/ui/util/util.js");
var Tips = require('common:widget/ui/tips/tips.js');
var dace = require("common:widget/ui/page-dace/page-dace.js");
var pageId = __daceDataNameOfPage;
//翻页默认配置
var defaultConfig = {
	// 翻页渲染的容器默认ID
	container : "#J_page",
	// 翻页行为是否异步，默认不开启，直接a链接翻页
	isAjax: false,
	// 当前页
	currntPage: 1,
	// 最大页数, 必要参数
	pageCount: 10,
	// 翻页参数
	paramPn : "pn",
	// 首页链接
	indexLink: "",
	// url模板
	urlFormat : "",
	// 翻页发生触发函数
	pageChange : function( page ){
		
	}
};
var pageTpl = [
	'<a dace-node="<@=pageId@>_homepage" data-page="<@=index.id@>" class="<@if (page == 1){@>disabled<@}@>"  href="<@=index.url@>">首页</a>',
	'<a dace-node="<@=pageId@>_previouspage" class="<@if (page < 2){@>disabled<@}@>" data-page="<@=prev.id@>" href="<@=prev.url@>">上页</a>',
	'<div class="pager_btn">',
		'<span class="page_num"><@=page@>/<@=pageCount@></span>',
		'<select id="J_selectcontainer"></select>',
	'</div>',
	'<a dace-node="<@=pageId@>_nextpage" class="<@if (page > pageCount - 1){@>disabled<@}@>" data-page="<@=next.id@>" href="<@=next.url@>">下页</a>',
	'<a dace-node="<@=pageId@>_lastpage" class="<@if (page == pageCount){@>disabled<@}@>" data-page="<@=last.id@>" href="<@=last.url@>">末页</a>'
].join("");

// 翻页类
var Pager = function( options ){
	this.opts = _.extend({}, defaultConfig, options);
	this.container = $(this.opts.container);
	this.selectContainer = this.container.find("#J_selectcontainer");
	this.currntPage = parseInt(this.opts.currntPage, 10);
	this.pageCount = parseInt(this.opts.pageCount, 10);

	this.supportPushState = util.isSuportPushState;
	this.init();
};

Pager.prototype = {
	init: function() {
		if(this.opts.isAjax){
			var page = 1;
			if(this.supportPushState){
				page = parseInt(util.getParamFromPathname(this.opts.urlFormat, "#{page}"), 10) || 1;
			} else{
				page = parseInt(util.getParamFromHash(this.opts.paramPn), 10) || 1;
			}
			page = page > this.pageCount ? this.pageCount : page;
			page = page < 1 ? 1 : page;
			this.render( page );
		} else{
			this.renderSelect();
		}
		this.pageShow = this.currntPage +" / "+ this.pageCount;
		this.bindEvent();
	},
	renderSelect: function(){
		var i = 1,
			current = this.currntPage,
			pageCount = this.pageCount,
			html = "";
		for(;i <= pageCount; i++){
			if(i === current){
				html += "<option value='"+ i +"' selected>第"+ i +"页</option>";
			} else{
				html += "<option value='"+ i +"'>第"+ i +"页</option>";
			}
		}
		this.selectContainer.html(html);
	},
	render: function( page ){
		this.currntPage = page;
		this.pageShow = this.currntPage +" / "+ this.pageCount;
		var urlFormat = this.opts.urlFormat;
		var indexLink = this.opts.indexLink;
		var prevId = page > 2 ? page - 1 : 1;
		var nextId = page < this.pageCount ? page + 1 : this.pageCount;
		var data = {
			index:{
				id : indexLink ? 0 : 1,
				url: indexLink || urlFormat.replace(/#{page}/, 1)
			},
			prev:{
				id : prevId,
				url: urlFormat.replace(/#{page}/, prevId)
			},
			pageId : pageId,
			page : page,
			pageCount : this.pageCount,
			next:{
				id : nextId,
				url : urlFormat.replace(/#{page}/, nextId)
			},
			last:{
				id : this.pageCount,
				url: urlFormat.replace(/#{page}/, this.pageCount)
			}
		};
		var html = _.template(pageTpl, data);
		this.container.find(".page_num").val(this.pageShow);
		this.container.html(html);
		this.selectContainer = this.container.find("#J_selectcontainer");
		this.renderSelect();
	},
	update: function( page ){
		//var base = location.pathname + location.search + location.hash;
		var hash = location.hash;
		var paramPn = this.opts.paramPn;
		var next = "";
		// 当支持history.pushState
		if(this.supportPushState){
			if(this.opts.urlFormat){
				var urlFormat = this.opts.urlFormat;
				var pathname = location.pathname;
				next = urlFormat.replace(/#{page}/i, page);
				next += hash;
				history.pushState({}, document.title, next);
			}

		// 不支持的时候，使用hash.
		} else{
			if(~hash.indexOf(paramPn + "=")){
				var reg = new RegExp(paramPn + "=-?\\d+","ig");
				next = hash.replace(reg, paramPn + "=" + page);
			} else{
				next = hash + (hash.indexOf("#") === 0 ? (hash.length > 0 ? "&" : "") : "#") + paramPn + "=" + page;
			}
			location.hash = next;
		}

		var handler = $.proxy(this.opts.pageChange, this);
		handler(page);

		this.render( page );
	},
	bindEvent: function(){
		var self = this;
		var isAjax = this.opts.isAjax;
		var urlFormat = this.opts.urlFormat;
		var pageCount = this.pageCount;
		$(this.opts.container).delegate("a", "click" ,function(e){
			e.preventDefault();
			var target = $(e.target);
			var isDisabled = target.hasClass("disabled");
			if(isDisabled) return;
			var page = target.data("page");
			if(isAjax && page){
				self.update(page);
			} else{
				location.href = target.attr("href");
			}
		});

        $(this.opts.container).delegate("#J_selectcontainer","change", function(e){
        	var selected = parseInt($(this).val(), 10);
        	dace.send(pageId + "_selectpage");
        	if(selected != self.currntPage){
				if(isAjax){
					self.update(selected);
				} else{
					location.href = urlFormat.replace("#{page}", selected);
				}
			} else{
				$(this).blur();
			}
        });
	}
};

/**
 *		
 *	@param container {string}, 翻页容器id query, 默认"#J_page"
 *	@param isAjax {boolean}, 翻页是否异步开关, 默认关闭
 *	@param currntPage {number}, 当前页, 默认为 1
 *	@param pageCount {number}, 最大页数, 必要参数，默认 10
 *	@param paramPn {string} , [可选] 翻页参数, 默认为"pn"
 *	@param indexLink {string}, [可选]， 默认第一页
 *	@param urlFormat {string}, url翻页规则模板
 *	@param pageChange {function}, 翻页发生触发函数
 *
 ***/
module.exports = function( options ){
	return new Pager( options );
};