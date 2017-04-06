{%extends file="common/page/layout.tpl"%}
{%block name="meta"%}
<link rel="canonical" href="{%$webUrl%}" />
<link rel="alternate" href="{%$deepLink%}" />
{%/block%}
{%block name="title"%}{%$news.title%}{%/block%}

{%block name="head_static"%}
    {%require name="news:static/comment/comment.scss"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    <script src="//res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    {%script%}
        wx.config({
            debug: false,
            appId: '{%$wechat.appId%}',
            timestamp: '{%$wechat.timestamp%}',
            nonceStr: '{%$wechat.nonceStr%}',
            signature: '{%$wechat.signature%}',
            jsApiList: [
                'onMenuShareTimeline',
                'onMenuShareAppMessage',
                'onMenuShareQQ',
                'onMenuShareWeibo',
                'onMenuShareQZone'
            ]
        });

        wx.ready(function(){
            var shareData = {
                title: "{%$news.share.wechat%}_虎扑体育App",
                desc: "{%$news.share.summary%}",
                link: "{%$news.share.url%}",
                imgUrl: "{%$news.share.img%}",
                success: function(res){
                },
                cancel: function(res){
                }
            }

            wx.onMenuShareTimeline(shareData);
            wx.onMenuShareAppMessage(shareData);
            wx.onMenuShareQQ(shareData);

            wx.onMenuShareWeibo({
                title: '{%$news.share.weibo%}', // 分享标题
                desc: shareData.desc, // 分享描述
                link: shareData.link, // 分享链接
                imgUrl: shareData.imgUrl, // 分享图标
                success: function () {
                // 用户确认分享后执行的回调函数
                },
                cancel: function () {
                // 用户取消分享后执行的回调函数
                }
            });

            wx.onMenuShareQZone({
                title: '{%$news.share.qzone%}', // 分享标题
                desc: shareData.desc, // 分享描述
                link: shareData.link, // 分享链接
                imgUrl: shareData.imgUrl, // 分享图标
                success: function () {
                // 用户确认分享后执行的回调函数
                },
                cancel: function () {
                // 用户取消分享后执行的回调函数
                }
            });
        });

        var platform = window.navigator.platform;
        var win = platform.indexOf("Win");
        var mac = platform.indexOf("Mac");

        $(".artical-content img").each(function() {
          if (win != -1 || mac != -1) {
            $(this).css({
              "width": "auto",
              "height": "auto"
            });
          } else {
            $(this).css({
              "width": "100%",
              "height": "auto"
            });
          }
        });

        //展示投票
        var voteRender = require("common:widget/ui-vote-onlyshow/ui-vote-onlyshow.js");
        $(".artical-content span._vote").each(function(idx, elem){
           voteRender("news", elem);
        });

        
        var Images = require("common:widget/click-image-show/click-image-show.js");
        //render gif
        Images.renderGifs($(".artical-content"), 0, 0, "news");

        //gif图
        $(".artical-content").delegate("img", "click", function(e) {
              var currentTarget = e.currentTarget;
              var realSrc = null;

              if (currentTarget.getAttribute("data-src")) {
                realSrc = currentTarget.getAttribute("data-src");
                currentTarget.src = realSrc;
                currentTarget.removeAttribute("data-src");
              }

              if (currentTarget.getAttribute("data-gif")) {
                Images.handlerClickGif(currentTarget, 0);
              }
        });
    {%/script%}

{%/block%}

{%block name="content"%}
{%if !empty($news.img)%}
    <div style="width:0px; height:0px; overflow:hidden"><img src="{%$news['img']%}" /></div>
{%/if%}
<section class="detail-wrap">
    {%if empty($smarty.get.xfr)%}
    <div class="top-down-app">
        <a href="{%$top_download_url%}" dace-node="{%$top_event%}">
            <div class="hupu-logo">
                <img src="//i1.hoopchina.com.cn/blogfile/201512/06/BbsImg144939425562185_92*92big.png" alt=""/>
            </div>
            <div class="app-info">
                <h4 class="name">
                    虎扑体育
                </h4>
                <div class="text">
                    {%$top_title%}
                </div>
                <div class="score">
                    <img src="//i1.hoopchina.com.cn/blogfile/201512/06/BbsImg144939425567994_97*17big.png" alt=""/>
                </div>
            </div>
            <div class="button-down">
                免费下载
            </div>
        </a>
    </div>
    {%/if%}

    {%widget
        name="news:widget/artical-title/title.tpl"
        tplType= "php"
    %}
    <article class="artical-content">
        {%if !empty($news.img_m)%}
            <div class="artical-main-pic">
                <img src="{%$news.img_m%}" alt=""/>
            </div>
        {%/if%}
        {%$news.content|escape:none%}
    </article>
    {%if !empty($news.tags)%}
        <section class="news-tags">
            <span class="tag-title">
                标签:
            </span>
            <div class="tags-list">
                {%foreach $news.tags as $item%}
                    <a href="{%$item.url%}" class="button-link" dace-node="news_tags_share">{%$item.name%}</a>
                {%/foreach%}
            </div>
        </section>
    {%/if%}

    {%widget
        name="news:widget/reply/reply.tpl"
        replyType="shareComment"
    %}
    {%if empty($smarty.get.xfr)%}
    <div class="down-app">
        <a href="{%$bottom_url%}" class="button-down-app" dace-node="{%$bottom_event%}">{%$bottom_title%}</a>
    </div>
    {%/if%}
</section>
{%/block%}
