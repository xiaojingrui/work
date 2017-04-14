/**
 * @file 论坛首页板块展示
 * @author huangmian@hupu.com
 * @date 2015-06-03
 */

"use strict";

var _ = require("underscore"),
    _key = "boardStorage";

var localCookie = {
    encode: function(s) {
        return config.raw ? s : encodeURIComponent(s);
    },

    decode: function(s) {
        return config.raw ? s : decodeURIComponent(s);
    },

    stringifyCookieValue: function (value) {
        return this.encode(config.json ? JSON.stringify(value) : String(value));
    },

    parseCookieValue: function (s) {
        if (s.indexOf('"') === 0) {
            // This is a quoted cookie as according to RFC2068, unescape...
            s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\');
        }

        try {
            // Replace server-side written pluses with spaces.
            // If we can't decode the cookie, ignore it, it's unusable.
            // If we can't parse the cookie, ignore it, it's unusable.
            s = decodeURIComponent(s.replace(pluses, ' '));
            return config.json ? JSON.parse(s) : s;
        } catch(e) {}
    },
    read: function (s, converter) {
        var value = config.raw ? s : this.parseCookieValue(s);
        return $.isFunction(converter) ? converter(value) : value;
    },
    setItem: function( key, value, options ){
        if (value !== undefined && !$.isFunction(value)) {
            options = $.extend({}, options);

            if (typeof options.expires === 'number') {
                var days = options.expires, t = options.expires = new Date();
                t.setTime(+t + days * 864e+5);
            }

            return (document.cookie = [
                this.encode(key), '=', this.stringifyCookieValue(value),
                options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
                options.path    ? '; path=' + options.path : '',
                options.domain  ? '; domain=' + options.domain : '',
                options.secure  ? '; secure' : ''
            ].join(''));
        }
    },
    getItem: function( key, value, options ){
        var result = key ? undefined : {};

        // To prevent the for loop in the first place assign an empty array
        // in case there are no cookies at all. Also prevents odd result when
        // calling $.cookie().
        var cookies = document.cookie ? document.cookie.split('; ') : [];

        for (var i = 0, l = cookies.length; i < l; i++) {
            var parts = cookies[i].split('=');
            var name = this.decode(parts.shift());
            var cookie = parts.join('=');

            if (key && key === name) {
                // If second argument (value) is a function it's a converter...
                result = this.read(cookie, value);
                break;
            }

            // Prevent storing a cookie that we couldn't decode.
            if (!key && (cookie = this.read(cookie)) !== undefined) {
                result[name] = cookie;
            }
        }

        return result;
    },
    removeCookie: function (key, options) {
        if (this.getItem(key) === undefined) {
            return false;
        }

        // Must not alter options, thus extending a fresh object...
        this.setItem(key, '', $.extend({}, options, { expires: -1 }));
        return !this.getItem(key);
    }

};

function supportsLocalStorage() {
    return 'localStorage' in window && window['localStorage'] !== null;
}

function supportsCookie() {
    return navigator.cookiesEnabled;
}

var dataer = {
    init: function(){
        if( supportsLocalStorage() ){
            this._data = localStorage;
        }else if( supportsCookie() ){
            this._data = localCookie;
        }else{
            this._data = null;
        }
    },
    get: function(key){
        if(!key){
            return null;
        }else{
            return this._data ? JSON.parse( this._data.getItem(key) ) : [];
        }
    },
    set: function( key,value ){
        if(!value){
            return null;
        }else{
            try{
                this._data && this._data.setItem(key, JSON.stringify( value ) );
            }catch(e){
                
            }
        }
    }
};


var defaultConfig = {
    // 判断是否为首页
    isIndex : true,
    // 判断是否登录
    isLogin : false,
    // 板块导航容器
    container : '.bbs-recommend-board ul',
    // 收藏板块内容
    collect : HPM.collectedForums || [],
    // 热门板块内容
    hot : HPM.hotForums || [],
    // 最多显示的板块数
    max : 12,
    // 登录后最多显示浏览过的热门板块数量
    max2 : 3,
    // 登录后最多显示收藏板块数量
    max3 : 6,
    // 当前板块id
    curFid : HPM.fid

};

var Board = function( options ){
    this.opts = _.extend({}, defaultConfig, options);

    this.container = $(this.opts.container);
    this.collect = this.opts.collect ;
    this.hot = this.opts.hot ;

    dataer.init();

    this.init();
};

Board.prototype = {

    init: function(){
        // 非论坛首页就存储
        if( !this.opts.isIndex ){
            this.storeBoard();
        }
        // 非论坛内页就展示
        if( !this.opts.isDetail ){
            if(!this.opts.isLogin){
                this.showBoard();
            }else{
                this.showBoardLogin();
            }
        }
        
        
    },
    // 未登录状态下显示的板块
    showBoard: function(){
        var that = this;
        var store = dataer.get(_key);
        
        if( store && store.length ){
            
            this.showVisitedInHot();

            var resultData = [];

            var resultData  = this.storeJSON.concat( this.hotRestJSON ) ;

            resultData = resultData.length > this.opts.max ? resultData.slice(0,this.opts.max) : resultData;
            
            this.appendBoard(resultData);

        }else{
            this.appendBoard(this.hot);
        }

    },
    // 登录状态下显示的板块
    showBoardLogin: function(){
        var that = this;

        this.showVisitedInHot();

        var resultData = [];

        var resultArr1Len  = this.storeJSON.length;

        var resultArr1Item = this.storeJSON;

        // 收藏板块与最近的三个已浏览板块去重
        this.collectRest = _.difference(this.collectFids, this.storeFids);
        
        this.collectRestJSON = _.map(this.collectRest, function(id, index) {
            return _.findWhere(that.collect, { fid: id });
        });

        var resultArr2Len = this.collectRestJSON.length > this.opts.max3 ? this.opts.max3 : this.collectRestJSON.length;

        // 随机取不超过6个的收藏版块
        var resultArr2Item = _.sample(this.collectRestJSON,resultArr2Len);

        var resultArr2 = _.map(resultArr2Item, function(item){ return item.fid;});
        // 浏览过的热门板块
        resultData = resultArr1Item.concat( resultArr2Item );

        // 如果不满足最大数量，则补充热门板块
        if( resultArr1Len + resultArr2Len < this.opts.max ){
            //热门板块与随机出来的收藏版块去重
            this.hotRestArr = _.difference(this.hotRestArr,resultArr2);

            this.hotRestJSON = _.map(this.hotRestArr, function(id, index) {
                return _.findWhere(that.hotRestJSON, { fid: id });
            });
            // 补充热门板块
            resultData = resultData.concat(this.hotRestJSON);

        }

        resultData = resultData.slice(0,this.opts.max);

        this.appendBoard(resultData);

    },  

    // 浏览过的板块与热门板块去重
    showVisitedInHot: function(curFid){
        var that = this;
        // 用fid来去重
        var store = dataer.get(_key);

        //localstorage存储的是字符串 要转换为json对象,并倒叙排列,即把最新浏览的放到最前显示
        if( store && store.length > 0 ){

            this.storeJSON = store.reverse();

            // this.storeJSON = this.storeJSON.length > this.opts.max2 ? this.storeJSON.slice(0,this.opts.max2) : this.storeJSON; 
            // 已浏览板块的fid数组
            this.storeFids = _.map(this.storeJSON, function(item){ return item.fid });
            
            if(this.opts.isList){
                this.storeFids = _.difference(this.storeFids,this.opts.curFid);
            }
            this.storeFids = this.storeFids.length > this.opts.max2 ? this.storeFids.slice(0,this.opts.max2) : this.storeFids; 
            
            this.storeJSON = _.map(this.storeFids, function(id, index) {
                return _.findWhere(store, { fid: id });
            });

        }else{
            this.storeJSON = [];
            this.storeFids = [];
        }
        
        // 热门板块的fid数组
        this.hotFids = _.map(this.hot, function(item){ return item.fid;});

        // 收藏板块的fid数组
        this.collectFids = _.map(this.collect, function(item){ return item.fid;});
        
        if(this.opts.isList){
            this.hotFids = _.difference(this.hotFids,this.opts.curFid);
            this.collectFids = _.difference(this.collectFids,this.opts.curFid);
        }



        // 热门与已浏览的前三个（可能不到三个）去重
        var repeatArr = _.intersection(this.storeFids, this.hotFids);
        
        this.hotRestArr = _.difference(this.hotFids,repeatArr);

        this.hotRestJSON = _.map(this.hotRestArr, function(id, index) {
            return _.findWhere(that.hot, { fid: id });
        });

    },

    // 在列表页和内页中存储板块
    storeBoard: function(){
        var _fid = HPM.fid;
        
        if(!_fid) return ;

        var board = [{
            "name": HPM.boardName,
            "fid": _fid,
            "url": HPM.boardLink,
            "tag": 2
        }]; 
        var store = dataer.get(_key);
        

        // 判断localstorage中有没有值
        if( store && store.length > 0 ){
            //判断是否已存在
            var inStorage = _.find(store, function(item){
                                return item.fid == _fid ;
                            });

            //如果不存在，则存入storage,且以存储数量小于12
            if( !inStorage ){ 
                if( store.length >= this.opts.max ){
                   store.shift(); 
                }
                store = store.concat(board);
            //如果存在的话，将其位置放到最新的  
            } else if(inStorage){
                var _index = _.indexOf(store,inStorage);
                var _tmp = store.splice(_index, 1);
                store = store.concat(_tmp);
            }

            dataer.set( _key, store );
        }
        else{
            dataer.set( _key, board );
        }

    },


    appendBoard: function(data){

        var tpl = "<li class='<@if(collect){@>collect<@}@>'>"
                 +   "<a href='/bbs/<@=fid@>' dace-node='<@=dace@>_tag_<@=tag@>'><@=name@></a>"
                 +"</li>";
        var html = "";
        for(var i = 0; i < data.length; i++){
            data[i].dace = __daceDataNameOfPage;
            data[i].tag = data[i].tag || "";
            data[i].collect = data[i].collect || "";
            html += _.template(tpl , data[i]);
        }
        this.container.html( html );
        this.container.parent().show(); 
    }

}

module.exports = function( options ){
    return new Board( options );
}

