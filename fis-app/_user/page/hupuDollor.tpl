{%extends file="common/page/layout.tpl"%}

{%block name="title"%}我的虎扑币{%/block%}

{%block name="head_static"%}
    <script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="user:static/hupuDollor/hupuDollor.scss"%}
    {%require name="user:static/hupuDollor/hupuDollor.js"%}
    <script>
        window.GM = {
            "nid": "{%$news.nid%}",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "client": "{%$client%}" || "x",
            "projectId":"{%$projectId%}"||"1",
            "version":"{%$version%}"||"7.0.6",
            "night":!!parseInt("{%$night%}", 10),
            "nopic":!!parseInt("{%$nopic%}", 10),
            "payMonth": "{%$payThisMonth%}",
            "payThreeMonth": "{%$payThreeMonth%}"
        };
    </script>
{%/block%}

{%block name="content"%}
<div class="gold-hd">
    <h3><span>当前{%$name|default:"虎扑币"%}:</span> <b class="color2" style="">{%$balance%}</b>
    {%if empty($name)%}
        <i class="icon-dollor"></i>
    {%else%}
        <i class="icon-gold"></i>
    {%/if%}
    </h3>
    <p class="list-title">{%$name|default:"虎扑币"%}明细 (近5个月明细)</p>
</div>
<div class="gold-list" id="wrapper">
    <div id="scroller">
        <ul class="items-list" id="detail-list">
           <!--  <li>
                <div class="item-infor">
                    <h4>送礼物给 虎扑慧体全明星赛（@信堂堂主）</h4>
                    <p>2015-12-23 16:53:03 </p>
                </div>
                <div class="item-extra">
                    <b class="color2">-1</b>
                </div>
            </li> -->
        </ul>
        <div id="loading" style="opacity: 0;"><span class="loadingIcon"></span></div>
    </div>
</div>
{%/block%}
