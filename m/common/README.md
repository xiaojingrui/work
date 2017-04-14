## 说明

	/widget 公共组件模板
	/widget/ui js的公共ui组件
	/static/global/global.js  全局的js. 可以用来初始化统计，分享这样的功能.
        /layout/layout.tpl  全局的模板. 钩子用 {%block%}{%/block%} 来做.
	/plugin 前端会使用到的 php插件，来提升smarty模板的能力.

## dace埋点

	在dom节点上添加 dace-node 属性. 
	如果需要在js中发的话， 

		var dace = require("common:widget/ui/page-dace/page-dace.js");
		dace.send('{$dace_id}');
	
	页面Id可以从全局变量	__daceDataNameOfPage 得到.

## 代码设计
	
	按照功能拆分代码，实现最小功能代码的最大复用. 将代码变成可配置的功能组件.