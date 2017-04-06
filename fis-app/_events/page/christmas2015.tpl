{%extends file="common/page/layout.tpl"%}

{%block name="title"%}NBA圣诞大战有奖竞猜{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="events:static/christmas2015/christmas2015.scss"%}
    {%require name="events:static/christmas2015/christmas2015.js"%}
    <script src="//res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script>
    window.GM = {
        "gamestatus": "{%$gamestatus%}",
        "isweixin": "{%$isweixin%}",
        "url": "{%$url%}",
        "friendid": "{%$friendid%}",
        "haveresult": "{%$haveresult%}"
    };
    </script>
    {%script%}
    wx.config({
        debug: false,
        appId: '{%$config["appId"]%}',
        timestamp: '{%$config["timestamp"]%}',
        nonceStr: '{%$config["nonceStr"]%}',
        signature: '{%$config["signature"]%}',
        jsApiList: [
            'onMenuShareTimeline','onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo'
        ]
    });
    wx.ready(function () {
        var shareData = {
            title: '{%$share_config['title']%}',
            desc: '{%$share_config['desc']%}',
            link: '{%$share_config["share_url"]%}',
            imgUrl: '{%$share_config["headimgurl"]%}',
            success:function(){
                window.location.href = "{%$share_config['share_url']%}";
            },
            cancel:function(){
            }
        };
        wx.onMenuShareTimeline(shareData);
        wx.onMenuShareAppMessage(shareData);
        wx.onMenuShareQQ(shareData);
        wx.onMenuShareWeibo(shareData);

    });
    {%/script%}
{%/block%}

{%block name="content"%}
<section class="xmas-wrap page1" id="J-page1" style="display: block;">
    <section class="banner auto-mr">
        <img src="../static/christmas2015/img/bigimg.png" alt="">
    </section>
    <section class="guess mod-content">
        {%if $gamestatus == 0%}
        <div class="bg-snow auto-bg">
            <img src="../static/christmas2015/img/bg6.png" alt="">
        </div>
        <div class="bg-top auto-bg">
            <img src="../static/christmas2015/img/bg1.png" alt="">
        </div>
        <p class="sub-title">全部猜对送10 Q币，球员得分相同，不影响前后排序</p>
        <div class="guess-list-wrap">
            <ul class="guess-list" id="J-guess-list">
                <li class="item1" data-rank="1">
                    <div class="num"><span>1</span></div>
                    <div class="head">
                        <img src="../static/christmas2015/img/img1.png" width="60" alt="">
                    </div>
                    <div class="data">
                        <div class="name">詹姆斯</div>
                        <div class="detail">26.4分 7.6板 6.3助</div>
                    </div>
                </li>
                <li class="item2" data-rank="2">
                    <div class="num"><span>2</span></div>
                    <div class="head">
                        <img src="../static/christmas2015/img/img2.png" width="60" alt="">
                    </div>
                    <div class="data">
                        <div class="name">库里</div>
                        <div class="detail">31.2分 5.4板 6.3助</div>
                    </div>
                </li>
                <li class="item3" data-rank="3">
                    <div class="num"><span>3</span></div>
                    <div class="head">
                        <img src="../static/christmas2015/img/img3.png" width="60" alt="">
                    </div>
                    <div class="data">
                        <div class="name">威斯布鲁克</div>
                        <div class="detail">25.3分 6.9板 9.3助</div>
                    </div>
                </li>
                <li class="item4" data-rank="4">
                    <div class="num"><span>4</span></div>
                    <div class="head">
                        <img src="../static/christmas2015/img/img4.png" width="60" alt="">
                    </div>
                    <div class="data">
                        <div class="name">哈登</div>
                        <div class="detail">28.8分 6.0板 6.8助</div>
                    </div>
                </li>
                <li class="item5" data-rank="5">
                    <div class="num"><span>5</span></div>
                    <div class="head">
                        <img src="../static/christmas2015/img/img5.png" width="60" alt="">
                    </div>
                    <div class="data">
                        <div class="name">杜兰特</div>
                        <div class="detail">26.6分 7.7板 4.3助</div>
                    </div>
                </li>
                <li class="item6" data-rank="6">
                    <div class="num"><span>6</span></div>
                    <div class="head">
                        <img src="../static/christmas2015/img/img6.png" width="60" alt="">
                    </div>
                    <div class="data">
                        <div class="name">罗斯</div>
                        <div class="detail">13.5分 3.3板 5.4助</div>
                    </div>
                </li>
            </ul>
            <ul class="change-list" id="J-change-list">
                <li class="item1"></li>
                <li class="item2"></li>
                <li class="item3"></li>
                <li class="item4"></li>
                <li class="item5"></li>
            </ul>
        </div>
        <div class="button submit" id="J-submit-btn"></div>
        {%else if $gamestatus == 2%}
        <div class="bg-snow bg-snow-result auto-bg">
            <img src="../static/christmas2015/img/bg6.png" alt="">
        </div>
        <div class="bg-top bg-top-result auto-bg">
            <img src="../static/christmas2015/img/bg7.png" alt="">
        </div>
        <div class="result-inner">
            <div class="title">
                <div class="line"></div>
                <div class="text">我的竞猜</div>
                <div class="line"></div>
            </div>
            <div class="result">
                <div class="head">
                    <img src="{%$userinfo.headimgurl%}" width="40" alt="">
                </div>
                <div class="detail">
                    <div class="info">
                        <span class="name">{%$userinfo.nickname%}</span>
                        <span class="date">{%$userinfo.subtime%}</span>
                    </div>
                    <div class="data">{%$userinfo.data%}</div>
                </div>
            </div>
            <div class="notice">
                你是第<span>{%$userinfo.paimin%}</span>名参与者，前6666名猜中用户可以获得10 Q币奖励
            </div>
            <div class="tips">
                【分享有奖】分享该链接给你的微信好友，如果你的好友猜中，你也可以获得10 Q币奖励
            </div>
        </div> 
        <div class="button share-btn"></div>
        {%else if $gamestatus == 1%}
        <div class="bg-snow bg-snow-result auto-bg">
            <img src="../static/christmas2015/img/bg6.png" alt="">
        </div>
        <div class="bg-top bg-top-result auto-bg">
            <img src="../static/christmas2015/img/bg7.png" alt="">
        </div>
        <div class="result-inner over-inner">
            <div class="header">
                <h1>赛前竞猜活动已结束！{%if $haveresult == 0%}等待开奖！{%/if%}</h1>
                <p>用虎扑体育客户端看圣诞大战赢真品球衣球鞋</p>
                <a href="//mobile.hupu.com/download/games?r=201512wechat02" class="download">立即下载</a>
            </div>
            {%if !empty($userinfo)%}
                <div class="title">
                    <div class="line"></div>
                    <div class="text">我的竞猜</div>
                    <div class="line"></div>
                </div>
                <div class="result">
                    <div class="head">
                        <img src="{%$userinfo.headimgurl%}" width="40" alt="">
                    </div>
                    <div class="detail">
                        <div class="info">
                            <span class="name">{%$userinfo.nickname%}</span>
                            <span class="date">{%$userinfo.subtime%}</span>
                        </div>
                        <div class="data">{%$userinfo.data%}</div>
                    </div>
                    {%if $gamestatus == 1%}
                        {%if $haveresult == 1%}
                            {%if $userinfo.binggo > 0%}
                            <div class="guess-status guess-right"></div>
                            {%else $userinfo.binggo == 0%}
                            <div class="guess-status guess-error"></div>
                            {%/if%}
                        {%/if%}
                    {%/if%}
                </div>
                {%if $userinfo.binggo>0%}
                <div class="notice">
                    你是第<span>{%$userinfo.binggo%}</span>名猜中者，前6666名猜中用户可以获得10 Q币奖励
                </div>
                {%/if%}
            {%else%}
                <div class="qq-query">
                    <div><input type="text" class="input-query-qq" placeholder="输入QQ号查询中奖结果"></div>
                    <div class="error input-query-error"></div>
                    <div class="query-btn" id="J-query-btn">查询</div>
                </div>
            {%/if%}
        </div>
        {%/if%}
    </section>
    <section class="friends-guess mod-content">
        <div class="bg-top"></div>
        {%if !empty($friendres) || !empty($fdata)%}
            <dl id="J-friends-guess-list"> 
                <dt>
                    <div class="mod-header">
                        <div class="icon left"></div>
                        <div>
                            <p class="title">感谢QQ浏览器提供Q币奖励</p>
                        </div>
                        <div class="icon right"></div>
                    </div>
                    <div class="qq-img"><img src="../static/christmas2015/img/qq.png" width="36" alt=""></div>
                    {%if $flag == 0%}
                    <div class="mod-header">
                        <div class="icon left"></div>
                        <div>
                            <p class="title">
                                {%if !empty($fdata)%}<span>{%$fdata.nickname%}</span>和{%/if%}好友们的竞猜
                            </p>
                            <p class="tips">微信好友猜对，您也可以获得10 Q币</p>
                        </div>
                        <div class="icon right"></div>
                    </div>
                    {%/if%}
                </dt>
                {%if $flag == 0%}
                    {%if !empty($fdata)%}
                    <dd>
                        <div class="head">
                            <img src="{%$fdata.headimgurl%}" width="40" alt="">
                        </div>
                        <div class="f-result">
                            <div class="info">
                                <span class="name">{%$fdata.nickname%}</span>
                                <span class="date">{%$fdata.subtime%}</span>
                            </div>
                            <div class="result">{%$fdata.data%}</div>
                            {%if $gamestatus == 1%}
                                {%if $haveresult == 1%}
                                    {%if $fdata.binggo > 0%}
                                    <div class="guess-status guess-right"></div>
                                    {%else $fdata.binggo == 0%}
                                    <div class="guess-status guess-error"></div>
                                    {%/if%}
                                {%/if%}   
                            {%/if%}
                        </div>
                    </dd>
                    {%/if%}
                    {%foreach $friendres as $val%}
                    {%if !empty($val.data)%}
                    <dd>
                        <div class="head">
                            <img src="{%$val.headimgurl%}" width="40" alt="">
                        </div>
                        <div class="f-result">
                            <div class="info">
                                <span class="name">{%$val.nickname%}</span>
                                <span class="date">{%$val.subtime%}</span>
                            </div>
                            <div class="result">{%$val.data%}</div>
                            {%if $gamestatus == 1%}
                                {%if $haveresult == 1 %}
                                    {%if $val.binggo > 0%}
                                    <div class="guess-status guess-right"></div>
                                    {%else $val.binggo == 0%}
                                    <div class="guess-status guess-error"></div>
                                    {%/if%}
                                {%/if%}
                            {%/if%}
                        </div>
                    </dd>
                    {%/if%}
                    {%/foreach%}
                {%/if%}
                <script id="J-more-page-tpl" type="text/template">
                    <@$(datas).each(function(index,item) { @>
                        <@if(item.data){@>
                        <dd>
                            <div class="head">
                                <img src="<@=item.headimgurl@>" width="40" alt="">
                            </div>
                            <div class="f-result">
                                <div class="info">
                                    <span class="name"><@=item.nickname@></span>
                                    <span class="date"><@=item.subtime@></span>
                                </div>
                                <div class="result"><@=item.data@></div>
                                <@if(GM.gamestatus == 1){@>
                                    <@if(GM.haveresult == 1){@>
                                        <@if(item.binggo > 0){@>
                                        <div class="guess-status guess-right"></div>
                                        <@}else if(item.binggo == 0){@>
                                        <div class="guess-status guess-error"></div>
                                        <@}@>
                                    <@}@>
                                <@}@>
                            </div>
                        </dd>
                        <@}@>
                    <@ }) @>
                </script>
            </dl>
            {%if !empty($ismore)%}
            <div class="more" id="J-more" data-f="{%$f%}">加载更多>>&nbsp;&nbsp;
                {%if !empty($total)%}
                共{%$total%}人
                {%/if%}
            </div>
            {%/if%}
        {%else%}
            <dl> 
                <dt>
                    <div class="mod-header">
                        <div class="icon left"></div>
                        <div>
                            <p class="title">感谢QQ浏览器提供Q币奖励</p>
                        </div>
                        <div class="icon right"></div>
                    </div>
                    <div class="qq-img"><img src="../static/christmas2015/img/qq.png" width="36" alt=""></div>
                    <div class="mod-header">
                        <div class="icon left"></div>
                        <div>
                            <p class="title">
                                {%if !empty($fdata)%}<span>{%$fdata.nickname%}</span>和{%/if%}好友们的竞猜
                            </p>
                            <p class="tips">微信好友猜对，您也可以获得10 Q币</p>
                        </div>
                        <div class="icon right"></div>
                    </div>
                </dt>
            </dl>
            <div class="nofriendsres">
                <p>暂无好友参与</p>
                <p>快去分享链接召唤好友参与吧</p>
            </div>
        {%/if%}
    </section>
    <section class="price-show mod-content auto-mr">
        <div class="hd">
            <img src="../static/christmas2015/img/adidas.png" alt="">
        </div>
        <div class="bd">
            <ul class="item">
                <li class="mr">
                    <img src="../static/christmas2015/img/gift1.png" alt="">
                </li>
                <li class="ml">
                    <img src="../static/christmas2015/img/gift2.png" alt="">
                </li>
            </ul>
            <ul class="item">
                <li class="mr">
                    <img src="../static/christmas2015/img/gift3.png" alt="">
                </li>
                <li class="ml">
                    <img src="../static/christmas2015/img/gift4.png" alt="">
                </li>
            </ul>
        </div>
    </section>
    <section class="share-rank mod-content">
        <div class="bg-top auto-bg">
            <img src="../static/christmas2015/img/bg3.png" alt="">
        </div>
        <div class="title title1">
            <div class="line"></div>
            <div class="text">
                <p>分享参与人数前3名</p>
                <p>即可获得阿迪达斯大礼包</p>
            </div>
            <div class="line"></div>
        </div>
        <ul class="top-list mod-list">
            {%foreach $paihan as $val%}
            {%if $val@index<3%}
            <li {%if $val@index == 0 %}class="rank1"{%else if $val@index == 1%}class="rank2"{%else if $val@index == 2%}class="rank3"{%/if%} >
                <div class="head-wrap">
                    <div class="head">
                        <img src="{%$val.headimgurl%}" width="30" alt="">
                    </div>
                    <div class="medal"></div>
                </div>
                <div class="name">{%$val.nickname%}</div>
                <div class="share">分享参与人数<span class="num">{%$val.nums%}</span>人</div>
            </li>
            {%/if%}
            {%/foreach%}
        </ul>
        <div class="title title2">
            <div class="line"></div>
            <div class="text">
                <p>分享参与人数前4-10名</p>
                <p>即可获得阿迪达斯球衣</p>
            </div>
            <div class="line"></div>
        </div>
        <ul class="bottom-list mod-list">
            {%foreach $paihan as $val%}
            {%if $val@index >= 3%}
            <li>
                <div class="head-wrap">
                    <div class="head">
                        <img src="{%$val.headimgurl%}" width="30" alt="">
                    </div>
                    <div class="icon">{%$val@index+1%}</div>
                </div>
                <div class="name">{%$val.nickname%}</div>
                <div class="share">分享参与人数<span class="num">{%$val.nums%}</span>人</div>
            </li>
            {%/if%}
            {%/foreach%}
        </ul>
    </section>
    <section class="rules mod-content">
        <div class="inner">
            <div class="title">
                <div class="icon left"></div>
                <div class="name">活动规则</div>
                <div class="icon right"></div>
            </div>
            <div class="content">
                <p>活动说明：</p>
                <p>1. 三重活动奖励</p>
                <p>(1) 猜对奖励：本次竞猜的题目为圣诞大战当天球员得分从高到低的排序，前6666名猜中用户可以获得10 Q币奖励。</p>
                <p>(2) 分享奖励：分享该链接给你的微信好友，只要有好友猜中，你就可以获得10 Q币奖励（可与猜对奖励叠加，但多名好友猜对时只记为一人）。</p>
                <p>(3) 实物大奖：分享链接参与用户数前3的分享者可获阿迪达斯大礼包（大礼包中包含球鞋和真品球衣，其中第一名获得罗斯6代战靴，第二名获得利拉德1代战靴，第三名获得沃尔2代战靴），4-10名可获训练服一件。</p>
                <p>2. 球员最终得分以虎扑体育App内完场数据为准，若出现球员未能上场的状况，则算该球员得分为0分。</p>
                <p>3. 本次活动通过QQ号作为唯一参与标识，每个QQ号仅限参与一次；我们将会在比赛结束7天内联系中奖用户并发放奖励，Q币奖励将直接发放到你的账户中。</p>
                <p>4. 活动截止时间为：<span>北京时间2015年12月25日23:59:59</span>。</p>
                <p>5. 对于使用各种软件或其他方式作弊的用户，将不予赠送；对已赠送的，有权要求用户返还；在法律许可范围内，虎扑体育保留本次活动的解释权。</p>
                <p>6. 下载虎扑体育App，观看圣诞大战现场直播，更多阿迪达斯礼包及Q币奖品等你来拿。</p>
                <p>7. 如遇不可抗力因素，赛事无法进行或取消时，虎扑体育在法律允许范围内有权决定取消、终止、修改或者暂停本活动，若有疑问请在QQ“找服务”中添加客服QQ号（800021359）。</p>
            </div>
        </div>
        <div class="bg-bottom"></div>
    </section>
    {%if $gamestatus == 0 || $gamestatus == 2%}
    <section class="fangpb">
        <a href="//mobile.hupu.com/download/games?r=201512wechat01"><img src="../static/christmas2015/img/fangpb.png" alt=""></a>
    </section>
    {%/if%}
</section>

<section class="xmas-result page2" id="J-page2" style="display: none;">
    <div class="guess mod-content">
        <div class="bg-snow bg-snow-result auto-bg">
            <img src="../static/christmas2015/img/bg6.png" alt="">
        </div>
        <div class="bg-top bg-top-result auto-bg">
            <img src="../static/christmas2015/img/bg7.png" alt="">
        </div>
        <div class="header">
            <div class="join-inner" style="display: none;">
                <div class="text">该QQ号已经参加过本次活动</div>
                <div class="icon"></div>
            </div>
            <div class="unjoin-inner"></div>
        </div>
        <div class="result-inner">
            <div class="title">
                <div class="line"></div>
                <div class="text">我的竞猜</div>
                <div class="line"></div>
            </div>
            <script id="J-join-success-tpl" type="text/template">
                <@ $(datas).each(function(index,item) { @>
                <div class="result">
                    <div class="head">
                        <img src="<@=item.headimgurl@>" width="40" alt="">
                    </div>
                    <div class="detail">
                        <div class="info">
                            <span class="name"><@=item.nickname@></span>
                        </div>
                        <div class="data"><@=item.value@></div>
                    </div>
                </div>
                <div class="expiry clearfix">
                    <div class="fl">兑奖QQ: <@=item.qq@></div>
                    <div class="fr"><span class="date"><@=item.subtime@></span></div>
                </div>
                <div class="notice">
                    你是第<span><@=item.paimin@></span>名参与者，前6666名猜中用户可以获得10 Q币奖励
                </div>
                <div class="tips">
                    【分享有奖】分享该链接给你的微信好友，如果你的好友猜中，你也可以获得10 Q币奖励
                </div>
                <@ }); @>
            </script>
        </div>
        <div class="button share-btn"></div>
        <div class="bg-bottom"></div>
    </div>
</section>

<div class="mod-show-mask" style="display: none;"></div>
<div class="mod-showBox price-showBox" style="display: none;">
    <div class="hd">领奖凭证</div>
    <div class="bd">
        <div class="tips">请输入你的QQ号作为领奖凭证，我们将在比赛结束后7日内统一发放Q币奖励到此QQ账户</div>
        <div class="form">
            <input type="tel" class="input qq" id="J-input-qq" placeholder="每个QQ号仅限参与一次"> <br />
            <input type="text" class="input code" id="J-input-code">
            <span class="code-img"><img src="//kanqiu.hupu.com/christmasact/makecode" alt=""></span>
            <span class="change-link" id="J-change-link">换一张</span>
            <p class="error" id="J-error" style="display: none;">您输入的QQ号格式不正确</p>
        </div>
        <div class="btn" id="J-confirm-btn" data-unionid="{%$unionid%}" data-f="{%$f%}" data-value="123456">确认</div>
    </div>
    <div class="close close-icon"></div>
</div>
<div class="remind-showBox" style="display: none;"></div>
{%/block%}