/**
 * @file 论坛首页板块展示
 * @author huangmian@hupu.com
 * @date 2015-10-28
 */

"use strict";

var _ = require("underscore");

var defaultConfig = {
    // 判断是否为首页
    isIndex : true,
    // 判断是否登录
    isLogin : true,
    // 板块导航容器
    container : '.top-board ul',
    // 收藏板块内容
    collect : HPM.collectedForums,
    // 热门板块内容
    hot : HPM.hotForums,
    // 当前板块id
    fid : HPM.fid

};

var Board = function( options ){
    this.opts = _.extend({}, defaultConfig, options);
    this.container = $(this.opts.container);
    this.collect = this.opts.collect ;
    this.hot = this.opts.hot ;
    this.init();
};

Board.prototype = {
    init: function() {

        if(this.opts.isLogin){
            this.showCollect();
        }else{
            this.showHot();
        }

    },
    showHot: function() {
        if(this.opts.isIndex){
            this.appendBoard(this.hot); 
        }else{
            this.appendBoard( this.deleteSameFid(this.hot, this.opts.fid) );
        }
    },
    showCollect: function() {
        if(this.collect.length >= 4){
            var restC = this.deleteSameFid(this.collect, this.opts.fid);
            this.appendBoard(restC); 
        }else{
            var restH = this.deleteSameArr(this.hot, this.collect),
                restH = this.deleteSameFid(restH, this.collect);

            var restC = this.deleteSameFid(this.collect, this.opts.fid);
            var arr = restC.concat(restH);
            this.appendBoard(arr);
        }
    },
    deleteSameFid: function(array, id) {
        return _.difference(array, _.findWhere(array, {fid: id}) );
    },
    deleteSameArr: function(array1, array2) {
        for(var i = 0; i < array2.length; i++){
            var fid = array2[i].fid;
            array1 = this.deleteSameFid(array1, fid)
        }
        return _.difference(array1, array2);
    },
    appendBoard: function(data){
        var tpl = "<li>"
                 +   "<a href='/bbs/<@=fid@>'><@=name@></a>"
                 +"</li>";
        var html = "";
        for(var i = 0; i < data.length; i++){
            data[i].dace = __daceDataNameOfPage;
            data[i].tag = data[i].tag || "";
            data[i].collect = data[i].collect || "";
            html += _.template(tpl , data[i]);
        }

        this.container.html( html );
    }

}

module.exports = function( options ){
    return new Board( options );
}