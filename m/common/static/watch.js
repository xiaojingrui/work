(function(win, doc){
    var _maxreport = 5,
        _reportCount = 0,
        _stack = {},
        debug = false,
        modId="",
        slice = Array.prototype.slice,
        reId = /id=\"(ads\d+_wrap)\"/,
        whites = [
            "(http:)?\/\/b[1-3]\.hoopchina\.com\.cn",
            "(http:)?\/\/w[1-3]\.hoopchina\.com\.cn",
            "(http:)?\/\/m\.hupu\.com",
            "(http:)?\/\/cc\.dace\.hupu\.com",
            "(http:)?\/\/www\.google-analytics\.com",
            "(http:)?\/\/res\.wx\.qq\.com",
            "(http:)?\/\/hm\.baidu\.com",
            "(http:)?\/\/js\.adm\.cnzz\.net",
            "(http:)?\/\/w\.cnzz\.com",
            "(http:)?\/\/c\.cnzz\.com"
        ],
        blackids = ["tlbstoolbar","progressholder","yd_f_gg","axonCloseAlert","ad_id","ad_id_b","bottomdiv_ad_id","bottomdiv_ad_id_b", "ad_id_total","BMSH_adbox","BMSH_adbox_content","axonSMSVerification","oMain","suspendDiv","everDiv","yodong_bt_show","ad_210106"];
    var delay = function(callback, time) {
        setTimeout(callback, time || 0);
    }
    var removeNode = function(node){
        if(node.parentNode){
            node.parentNode.removeChild(node);
        }
    }
    /**
     * 上报枚举类型
     * pid 标记类型
     * 0, 上报页面时间
     * 1, 上报隐藏的iframe
     * 2, 上报页面被插入JS
     * 3, 上报页面最后的Node
     * 4, 上报页面删除的id广告
     */
    var getHash = function(msg){
        var key = "e_";
        if(typeof msg === "string" && msg.length){
            var c = msg.split(""),
                i = 0,
                t = 0,
                len = c.length;
            for(;i<len;i++){
                t += (c[i] != "" && c[i].charCodeAt) ? c[i].charCodeAt() : 0;
            }
            key += t + "_" + len;
        }
        return key;
    };

    var watch = {
        version:"1.0.2",
        start: function(){
            var self = this;

            this.watchDomInsert();
            //debug模式, 不存在modId，也不开启debug模式
            try{
                var script = document.getElementById("watch_script");
                modId = script.getAttribute("data-mid");
                if(!!modId){
                     debug = !localStorage.getItem("watch_debug");
                } else{
                     debug = false;
                }
                //this.watchScript();

            }catch(e){
                debug = false;
            }

            var errhander = debug ? function(msg, url, line, col, error) {
                //最大次数, 取消onerror， 抛出错误.
                if(_reportCount++ >= _maxreport){
                    win.onerror = function(){};
                    return true;
                }
                var errurl = url || location.href;
                //无意义的报错，或者不存在报错url，不收集.
                if (msg == "Script error." || !url) {
                    return true;
                }
                //采用异步的方式上报
                delay(function() {
                    var data = {
                    };
                    //不一定所有浏览器都支持col参数
                    col = col || (win.event && win.event.errorCharacter) || 0;
                    data.ju = errurl;
                    data.l = line;
                    data.c = col;
                    if (!!error && !!error.stack) {
                        //如果浏览器有堆栈信息
                        //直接使用
                        data.m = error.stack.toString();
                    } else if (!!arguments.callee) {
                        //尝试通过callee拿堆栈信息
                        var ext = [];
                        var f = arguments.callee.caller,
                            c = 3;
                        //这里只拿三层堆栈信息
                        while (f && (--c > 0)) {
                            ext.push(f.toString());
                            if (f === f.caller) {
                                break; //如果有环
                            }
                            f = f.caller;
                        }
                        ext = ext.join(",");
                        data.m = ext;
                    }
                    data.m = data.m || msg;
                    //把data上报到后台！
                    self.send(data);
                });

                return true;
            } : function(){};

            win.onerror = errhander;
        },
        /**
         * 监控页面是否为白名单内的JS
         */
        watchScript: function(){
            var self = this;
            var checkScript = function(){
                var scripts = document.getElementsByTagName("script");
                    scripts = slice.call(scripts);
                var plist = [];

                for(var i=0;i<scripts.length;i++){
                    var jsSrc = scripts[i].getAttribute("src");
                    if(jsSrc){
                        var pass = false;
                        for(var j=0;j<whites.length;j++){
                            var wHost = new RegExp("^" + whites[j], "i");
                            if(wHost.test(jsSrc)){
                                pass = true;
                            }
                        }
                        if(!pass){
                            plist.push(jsSrc);
                        }
                    }
                }
                //如果存在非白名单的JS，则上报.
                // if(plist.length > 0){
                //     //页面被插入Js，上报类型为 2
                //     //self.record("js:["+ plist.join("|") +"]", 2, scripts.length);
                //
                //     //页面被劫持，上报页面最后三个节点信息.
                //     //self.watchLastNode();
                // }
            };
            var loadEvent = function(){
                //load之后立即监听
                checkScript();
                self.checkfoul();
                self.hideHtml();
                //防止动态插入JS. 10s自动执行一遍.
                setTimeout(checkScript, 10000);
            };

            //忽略错误.
            try{
                if(win.addEventListener){
                    win.addEventListener("load", loadEvent, false);
                }
            }catch(e){

            }
        },
        /**
         * 上报页面最后3个节点内容
         */
        watchLastNode: function(){
            var last = document.body.lastChild;
            var prevLast = last.previousSibling;
            var prevPrev = prevLast.previousSibling;
            var nodes = [last, prevLast, prevPrev];
            var nodeMsg = "";
            for(var idx in nodes){
                var current = nodes[idx];
                var tagName = current.tagName;
                if(current.nodeType === 1
                && current.className != "ui-page-tools"
                && tagName != "SCRIPT"
                && tagName != "IFRAME"
                ){
                    var hasLink = slice.call(current.getElementsByTagName("a"));

                    if((hasLink && hasLink.length) || current.tagName === "A"){
                        nodeMsg += current.outerHTML;
                    }
                }
            }
            if(nodeMsg.length){
                this.record("last:["+ nodeMsg +"]", 3);
            }
        },
        /**
         * 监听页面dom插入
         */
        watchDomInsert: function(){
            var self = this;
            //有DOM插入, 尝试隐藏iframe.
            var checkDomInsert = function(e){
                try {
                    var html = e.srcElement.outerHTML || e.srcElement.wholeText;
                    var res = html.match(reId);
                    if (res && res.length === 2) {
                        blackids.push(res[1]);
                    }
                } catch (e) {}
                delay(function(){
                    self.checkfoul();
                    self.hideHtml();
                });
             };

            //忽略错误.
            try{
                win.addEventListener("DOMNodeInserted", checkDomInsert);
            }catch(e){}
        },
        /**
         * 检查脏id
         */
        checkfoul: function(){
            var self = this;
            delay(function(){
                var i = 0,
                    len = blackids.length;
                for (var i = 0; i < len; i++) {
                    var node = document.getElementById(blackids[i]);
                    if(node){
                        removeNode(node);
                        //拦截div, type:4
                        self.record("ads:["+ blackids[i] +"]", 4);
                    }
                }
            });
        },
        /**
         * 隐藏iframe
         */
        hideHtml: function(){
             var self = this;
             delay(function(){
                 var iframes = document.getElementsByTagName("iframe");
                     iframes = slice.call(iframes);
                 for(var i=0;i<iframes.length;i++){
                    var current = iframes[i];
                    //拦截http开头的链接.
                     if(current.src && current.src.indexOf("http") === 0){
                        current.style.cssText = "display:none";
                        //拦截iframe, type:1
                        self.record("iframe:["+ current.src +"]", 1);
                     }
                 }
             });
        },
        mergeDevice: function(info){
            var scr = win.screen;
            info.appid = 1;
            info.u = doc.location.href;
            info.mid = modId;
            info.s = scr ? (scr.width + "x" + scr.height) : "-";
            info.pid = "-1";
            return info;
        },
        send: function(data){
            //正常js报错, 无type
            var params = this.mergeDevice(data);
            this.reportlog(params);
        },
        record: function(msg, type, count, mid){
            var params = this.mergeDevice({});
            params.mid = mid||modId;
            params.m = msg||"-";
            params.c = count;
            params.l = 0;
            params.pid = type; //此类型方便后期统计区分.
            params.ju = '-';
            this.reportlog(params);
        },
        reportlog: function(data){
            //去重
            var _hash = getHash(data.ju + data.l + data.c + data.m + data.pid);
            if(_stack[_hash]) return;
            _stack[_hash] = true;

            var sendURL = "//js.pub.hupu.com/a.gif?";
            var query = [];
            for(var key in data){
                query.push(key + "=" + encodeURIComponent(data[key]));
            }
            sendURL+=query.join("&");

            var _img = new Image();
            _img.src = sendURL;
            _img.onload = _img.onerror = function(){
                _img.onload = _img.onerror = null;
                _img = null;
            }
        }
    };
    watch.start();
    win.Jswatch = {
        record : function(){
            watch.record.apply(watch, arguments);
        }
    };
})(window, document);
