/**
 * @file 模拟select
 * @authoer huangmian@hupu.com
 **/

"use strict";

var _ = require("underscore"),
    Tips = require('common:widget/ui/tips/tips.js'),
    _key = "history";

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
    removeItem: function (key, options) {
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
    },
    remove: function( key ){
        if(!key){
            return null;
        }else{
            try{
                this._data && this._data.removeItem(key);
            }catch(e){
                
            }
        }
    }
};

var SelectTools = {
    init: function(){
        this.form = $('.search-form');
        this.$select = $('.search-range');
        this.len = this.$select.length;
        this.$select.hide();
        dataer.init();
        this.historyArr = [];
        this.render();       
    },
    render: function(){
        var len = this.len;
        for(var i = 0; i < len; i++){
            var $divSelWrap = $('<div class="divSelWrap divSelWrap'+(i+1)+'"><div class="divSelInner"><span></span></div></div>'),
                $divSelInner = $divSelWrap.find('.divSelInner'),
                $ul = $('<ul></ul>'),
                $em = $('<em></em>');

            var _opt = $('option',this.$select[i]);

            for(var j = 0; j < _opt.length; j++){
                if( $(_opt[j]).attr('selected') ){
                    $divSelInner.find('span').text($(_opt[j]).text()).data('index',j);
                    continue;
                }

                var _val = $(_opt[j]).text(),
                    $li = $('<li data-index='+j+'>'+_val+'</li>');

                $ul.append($li);
            }

            if(!this.$select.hasClass('select-sp')){
                $divSelInner.append($em);
            }

            $divSelWrap.append($ul);

            $(this.$select[i]).after($divSelWrap);

        }

        if(!HPM.isLogin && HPM.isSearchIndex){
            this.renderSearch();    
        }   
        this.bindEvent($divSelInner);
    },

    getQueryString: function(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    },
    
    bindEvent: function(el){
        var _list = el.next('ul'),
            _listItem = _list.find('li'),
            _optRes = el.find('span'),
            self = this;

        this.submitBtn = $('.search-btn');

        if(_list.find('li').length < 0) return;

        // 点击展开/收起
        el.on('click', function(){
            if($(this).hasClass('on')) {
                $(this).removeClass('on');
                _list.hide();
            }else{
                $(this).addClass('on');
                _list.show();
            }
        })

        //切换选项
        _listItem.on('click', function(){

            var _index = $(this).data('index'),
                _val = $(this).text(),
                _elIndexEl = _optRes.data('index'),
                _elVal = _optRes.text();

            if(_val == '全部' && !HPM.isLogin){
                HPM.popLogin();
                _list.hide();
                return;
            }
            _optRes.data('index', _index).text(_val);
            $(this).data('index', _elIndexEl).text(_elVal);
            $(this).parent().siblings('.divSelInner').removeClass('on');
            _list.hide();  

            el.parent().siblings('select').find('option').removeAttr('selected').eq(_index).attr('selected','selected');
        })

        // 点击空白处收起
        $(document).bind('click', function(e){
            var target = $(e.target);
            if( $('.divSelInner').hasClass('on') && target.closest(".divSelWrap").length == 0){
                $('.divSelInner').removeClass('on');
                _list.hide();
            }
        })

        if( $('.recent-search-list li').length > 0 ){
            $('.recent-search-list li').on('click', function() {
                $('#J_keyword').val($(this).text());
                self.submitBtn.trigger('click');
            })
        }
        

        // 提交
        this.submitBtn.on('click', function(e) {
            e.preventDefault();
            var _keyword = $.trim( $('#J_keyword').val() ),
                _illegal = _keyword.match(/((?=[\x21-\x7e]+)[^A-Za-z0-9])/g);

            if(_keyword == ''){
                Tips("请输入搜索内容");
                return;
            }else if(_illegal && _illegal.length > 3){
                Tips("输入非法字符！");
                return;
            }

            $('#J_keyword2').val(encodeURI(_keyword));

            var _val = $('option').not(function(){ return !this.selected }).text();
            
            if(_val == '专区'){

                var _fromBBS = parseInt(self.getQueryString('fromBBS'));

                $('input[name="fid"]').val(_fromBBS);

            }else if(_val == '全部' && self.getQueryString('fid')){

                $('input[name="fid"]').val('');

            }else{
                
                $('input[name="fid"]').val('');
            
            }

            // 未登录用户记录在本地
            if( !HPM.isLogin ){
                self.storageSearch($('#J_keyword').val());
            }

            self.form.submit();

        });

        // 删除搜索记录
        $('#J_rmHistory').on('click', function() {

            if( HPM.isLogin ){
                $.ajax({
                    url: '/bbs/searchthreads?uid='+HPM.uid+'&del=1',
                    type: 'GET',
                    dataType: 'json',
                    success: function(data){
                        if(data.status == 200){
                            Tips(data.msg);
                            $('.recent-search').hide();
                        }else{
                            Tips(data.msg);
                        }
                    }
                })
                
            }else{
                dataer.remove(_key);
                Tips(data.msg);
                $('.recent-search').hide();
            }
        })

    },
    renderSearch: function(){
        var _list = '',
            store = dataer.get(_key),
            self = this;

        if( store && store.length > 0 ){
            var _html = '<div class="recent-search">\
                        <div class="title">\
                            <h3>最近搜索</h3>\
                            <em class="delete-icon" id="J_rmHistory"></em>\
                        </div>\
                        <ul class="recent-search-list"></ul>\
                    </div>';

            $('.search-wrap').append(_html);

            var _store = store.reverse();

            _.each(_store,function(item){
                _list += '<li>'+item+'</li>';
            })

            $('.recent-search-list').html(_list);

            $('.recent-search-list li').on('click', function() {
                $('#J_keyword').val($(this).text());

                self.submitBtn.trigger('click');
                
            })

        }
        

    },

    storageSearch: function(keyword){
        var history = [],
            store = dataer.get(_key);

        if( store && store.length > 0 ){
            var inStorage = _.find(store, function(item){
                                return item == keyword ;
                            });

            //如果不存在，则存入store,且以存储数量小于12
            if( !inStorage ){ 
                if( store.length >= 10 ){
                   store.shift(); 
                }
                store = store.concat(keyword);
            //如果存在的话，将其位置放到最新的  
            } else{
                var _index = _.indexOf(store,inStorage);
                var _tmp = store.splice(_index, 1);
                store = store.concat(_tmp);
            }

            dataer.set( _key, store );
        }else{
            history.push(keyword);
            dataer.set(_key, history);
        }
    }

}

module.exports = {
    init: function(){
        return SelectTools.init();
    }
}
