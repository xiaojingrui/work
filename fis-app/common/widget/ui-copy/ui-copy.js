var Versions = require("common:widget/ui-versions/ui-versions.js");

var copy = {
    init: function( ver ){
        var appVersion =  new Versions(ver);
        if(appVersion.gte("7.0.15")){
            window.shcopy = function(res){
                if(!res.status){
                    HupuBridge.send("hupu.ui.copy", {
                        content: res.data
                    }, function(){});
                }
            }

            var script = document.createElement("script");
            script.src = '//st1.shihuo.cn/kanqiu.js?callback=shcopy&t=20161116';
            document.head.appendChild(script);
        }
    }
}

module.exports = copy
