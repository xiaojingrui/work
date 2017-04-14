{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="bbs:static/detail/detail.scss"%}
    <link rel="canonical" href="{%$url%}" />

    <script>
        // 当前板块名称
        HPM.boardName = '{%$thread.boardname%}' || '';
        // 当前板块ID 做链接用
        HPM.fid = '{%$thread.fid%}' || '';
        // focus_author
        HPM.focus_author = !!parseInt('{%$focus_author%}' || '');
        // 当前板块链接
        HPM.boardLink = '/bbs/{%$thread.fid%}';
        // token
        HPM.token = '{%$token%}';
        // csrf
        HPM.csrf = '{%$no_csrf_code%}';
        // 帖子ID
        HPM.tid = '{%$thread.tid%}';
        HPM.puid = '{%$thread.puid%}';
        HPM.author = '{%$author%}';
        //域名
        HPM.Url = "{%$url%}";
        HPM.author_url = "{%$author_url%}";
        HPM.baseUrl = "{%$baseUrl%}";
        HPM.pageCount = "{%$pageCount%}";
        HPM.replies = {%json_encode($replies)%};
        HPM.page = "{%$page%}";
        //是否考试
        HPM.exam_paper_url = '{%$exam_paper_url%}';
        HPM.back_from_exam = !!parseInt('{%$back_from_exam%}');
        HPM.support_webp = "{%$support_webp%}";
    </script>
    {%script%}
        var toShare = require("common:widget/ui/share/share.js");
            //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
            toShare();
        });

        //页面分享按钮
        $("#J_buttonShare").on("click", function(){
            $(document).trigger("page:share");
        });

        //底部的刷新
        var tools = require("common:widget/ui/page-tools/page-tools.js");
            tools.initTools({
            reply : true,
            replyHandler: function(){
                $(document).trigger("page:reply");
            }
        });

        // 收藏
        var Star = require("bbs:widget/star/star.js");
        Star.init();

        //微信中屏蔽该请求
        {%if $smarty.server.HTTP_USER_AGENT|strpos:'MicroMessenger' == false%}
          //模拟PC统计请求
          var oImg = new Image();
          oImg.onload = oImg.onerror = function(){
            oImg.onload = oImg.onerror = null;
            oImg = null;
          }

          //延迟发送.
          setTimeout(function(){
            oImg.src = "//msa.hupu.com/thread_hit?tid=" + HPM.tid;
          }, 800);
        {%/if%}

        // 微信图片切换
        // var WeixinTool = require("common:widget/ui/weixin-tool/weixin-tool.js");
        // WeixinTool.init('.article-content');

        // 投票
        var voteRender = require("common:widget/ui-vote/ui-vote.js");
        $(".article-content span._vote").each(function(idx, elem){
           voteRender(elem);
        });

        //2016-11-08 add newreply by 洪源
        $.ajax({
          url: '//msa.hupu.com/check_newreply?tid='+ HPM.tid,
          type: "GET",
          dataType : 'jsonp',
          success: function(){},
          error: function(){}
        });
    {%/script%}

{%/block%}
{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=true
        hasPostTools=true
        isDetail=true
    %}

    {%if !empty($smarty.get.p)%}
        {%widget name="bbs:widget/merge-info/merge-info.tpl" data=base64_decode(str_replace(' ', '+', $smarty.get.p))%}
    {%/if%}
    {%widget name="bbs:widget/detail-title/title.tpl"%}

    {%if !empty($custom["m_top"])%}
        {%widget name="common:widget/live-text/live.tpl" data=$custom["m_top"]%}
    {%/if%}

    {%widget
        name="common:widget/prediction-tips/prediction-tips.tpl"
        urlParam="?dace_from=bbs#today"
    %}



    <section class="detail-wrap">
        <!--
        <section class="hotspot-news">
            <div class="hotspot-news-wrap">
                <div class="hotspot-news-title">
                    热点
                </div>
                <div class="hotspot-news-list">
                    <a href="#">NBA</a>
                    <a href="#">季后赛</a>
                    <a href="#">花絮插播</a>
                </div>
            </div>
        </section>
        -->
        <section class="detail-content">
            <!-- content start -->
            <article class="article-content">
                {%$thread.content|escape:none%}
            </article>
            <!-- content end -->

            {%if !empty($thread.viainfo)%}
                <div class="article-form">
                    {%$thread.viainfo|escape:none%}
                </div>
            {%/if%}

        </section>


        {%widget
            name="bbs:widget/reply/reply.tpl"
        %}
        <!--帖子底部回复栏-->
        {%widget
            name="bbs:widget/reply-box/reply-box.tpl"
        %}
        <!-- 其他人正在看 –start -->
        {%if !$_islogin %}
            {%if !empty($relation) || !empty($kaluli)%}
                <div class="guess-like m-card-split-line" section-exposure="{%$id4dace%}_showbbs">
                    <div class="title special_title">
                        <h2>其他人正在看</h2>
                    </div>
                    <div class="bd">
                        <ul class="list">
                            {%if !empty($kaluli)%}
                                {%foreach from=$kaluli item=val name=key%}
                                   <li>
                                        <a href="{%$val.detail_url%}" dace-node="{%$id4dace%}_bbs">
                                            <h4 class="name">{%$val.title|escape:none%}</h4>
                                            <div class="status-bar">
                                                <div class="news-info">
                                                    <span class="news-source">
                                                        {%$val.come%}
                                                    </span>
                                                    <!--
                                                    <span class="news-time">
                                                        {%$val.time%}
                                                    </span>
                                                    -->
                                                </div>
                                                {%if !empty($val.replies)%}
                                                <div class="news-comment">
                                                    <i class="icon-comment"></i><span class="comment-number">{%$val.replies%}</span>
                                                </div>
                                                {%/if%}
                                            </div>
                                        </a>
                                    </li>
                                {%/foreach%}
                            {%/if%}
                            {%if !empty($relation)%}
                                {%foreach from=$relation item=val name=key%}
                                   <li>
                                        <a href="{%$val.link%}" dace-node="{%$id4dace%}_bbs">
                                            <h4 class="name">{%$val.title|escape:none%}</h4>
                                            <div class="status-bar">
                                                <div class="news-info">
                                                    <span class="news-source">
                                                        {%$val.board%}
                                                    </span>
                                                    <!--
                                                    <span class="news-time">
                                                        {%$val.time%}
                                                    </span>
                                                    -->
                                                </div>
                                                {%if !empty($val.replies)%}
                                                <div class="news-comment">
                                                    <i class="icon-comment"></i><span class="comment-number">{%$val.replies%}</span>
                                                </div>
                                                {%/if%}
                                            </div>
                                        </a>
                                    </li>
                                {%/foreach%}
                            {%/if%}
                        </ul>
                    </div>
                </div>
            {%/if%}
        {%/if%}
        <!-- 其他人正在看 end -->

        <!-- 相关新闻 start  与其他人正在看合并了
        {%widget
            name = "common:widget/relative-news/relative-news.tpl"
            data = $relevantnews
            dace = "{%$id4dace%}_news"
            urlfrom = "bbshotnews"
            sectionExposure="{%$id4dace%}_shownews"
        %}
        -->
        <!-- 相关新闻 end-->

        <!-- 推荐热点 start-->
        {%** 推荐热点模块不上线先注释
            {%widget
                name = "common:widget/hot-spot/hot-spot.tpl"
                data = $hotSpots
                dace = "{%$id4dace%}_hot"
                urlfrom = "bbshotnews"
                sectionExposure="{%$id4dace%}_showhot"
            %}
        **%}
        <!-- 推荐热点 end-->

    </section>
    {%if $is_show_taobao|default:false%}
    <script src="//st1.shihuo.cn/alibtn.js" data-unit="px" data-style="right:-8" data-size="60" data-type="fixed" data-url="http://www.shihuo.cn/shihuo_activity_tmall_page.html"></script>
    {%/if%}
{%/block%}
{%block name="footer"%}
    {%if $page == "1" %}
      {%widget name="common:widget/footer/footer.tpl" footerType="bbsdetail"%}
    {%else%}
        {%widget name="common:widget/footer/footer.tpl" bbsFooterNav="bbsFooterNav"%}
     {%if !empty($nfl)%}
      <script type="text/javascript" src="//partner.googleadservices.com/gampad/google_service.js"></script>
      <script>
          (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

          ga('create', 'UA-63221919-2', 'auto');
          ga('send', 'pageview');
      </script>
      {%/if%}
    {%/if%}
{%/block%}
