{%extends file="common/page/layout.tpl"%}

{%block name="title"%}支付测试页面{%/block%}

{%block name="head_static"%}
    <script type="text/javascript" src="//b3.hoopchina.com.cn/games/js/hpbridge_v1.0.1.js"></script>
    {%require name="common:static/js/zepto/zepto.js"%}
{%/block%}

{%block name="content"%}
    {%$payweixinstring='{"appid":"wx89dccb9b2afda7ce","noncestr":"3sH11gFX30k2uV2jhp84YiSJiouytoIX","package":"Sign=WXPay","partnerid":"1381031602","prepayid":"wx201608221506548793e4a2810246167829","timestamp":1471849614,"sign":"D00698CD5BBAF52EA61E5E5204CBECC2"}'%}

    {%if !empty($paystring)%}
    <h3>支付宝code</h3>
    <pre>{%$paystring%}</pre>
    {%/if%}

    {%if !empty($payweixinstring)%}
    <h3>微信code</h3>
    <pre>{%$payweixinstring%}</pre>
    {%/if%}
    <button id="J_try_pay">尝试调起支付宝支付</button><br>
    <button id="J_try_weixin_pay">尝试调起微信支付</button><br>

    <button id="J_try_apple_pay">尝试调起Apple支付</button><br>

    <a href="hupu://bbs/board/1048">hupu://bbs/board/1048</a><br>

    <a href="hupu://more/service">hupu://more/service</a><br>

    <a href="kanqiu://more/service">kanqiu://more/service</a>
    {%script%}
    window.GM = {
        paystring: "{%$paystring%}",
        payWeixinString: "{%$payweixinstring%}"
    };
    $("#J_try_pay").click(function(){
        HupuBridge.send("hupu.pay.order", {
            "channel": "alipay",
            "paystring": GM.paystring
        }, function(){});
    });

    $("#J_try_weixin_pay").click(function(){
        HupuBridge.send("hupu.pay.order", {
            "channel": "weixin",
            "paystring": GM.payWeixinString
        }, function(){});
    });

    $("#J_try_apple_pay").click(function(){
        HupuBridge.send("hupu.pay.order", {
            "channel": "iospro",
            "orderId": "1100",
            "paystring": "iosprohupudollor01"
        }, function(){});
    });

    function initBridge(callback) {
        if(window.HupuBridge){
            callback();
        }else{
            document.addEventListener("hupuBridgeReady", function(){
                callback();
            });
        }
    }
    initBridge(function(){
            HupuBridge.register("hupu.pay.callback", function(msg) {
                alert("支付成功了");
                alert(JSON.stringify(msg, null, 4));
            });
    });

    {%/script%}
{%/block%}
