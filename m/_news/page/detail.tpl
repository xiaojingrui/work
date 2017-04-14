{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="news:static/detail/detail.scss"%}
    {%require name="news:static/detail/detail.js"%}
    <script>
        HPM.pageCount = "{%$pageCount%}";
        HPM.curUrl = "{%if !empty($newspageurl)%}{%$newspageurl%}{%else%}{%/if%}";
        HPM.tid = "{%$id%}";
    </script>
    {%script%}

        //底部的刷新
        var tools = require("common:widget/ui/page-tools/page-tools.js");
        tools.initTools({
            reply : true,
            replyHandler: function(){
                $(document).trigger("page:reply");
            }
        });

        // 微信图片切换
        var WeixinTool = require("common:widget/ui/weixin-tool/weixin-tool.js");
        WeixinTool.init('.article-content');
    {%/script%}

{%/block%}
{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=false
        isDetail=true
    %}

    {%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}

    {%if !empty($custom["m_top"])%}
    {%widget name="common:widget/live-text/live.tpl" data=$custom["m_top"]%}
    {%/if%}

    {%widget
        name="common:widget/prediction-tips/prediction-tips.tpl"
        urlParam="?dace_from=bbs#today"
    %}

    <section class="detail-wrap">
        <section class="detail-content">
            {%widget
                name = "news:widget/artical/artical.tpl"
            %}

            <div class="down-kanApp">
                <a href="http://mobile.hupu.com/download/games/?_r=mxinwenneiye" class="down-link" dace-node="{%$id4dace%}_download_news">下载虎扑体育App，看更多相关内容 </a>
            </div>
            <!-- 支付反对区域 start-->
            <!-- <div class="choice" news-id="{%$detail.id%}">
                <div class="choice-item support">
                    <i></i><strong>支持</strong>
                    {%if $detail.support>0%}
                    <span>({%$detail.support%})</span>
                    {%else%}
                    <span></span>
                    {%/if%}
                </div>
                <div class="choice-item against">
                    <i></i><strong>反对</strong>
                    {%if $detail.against>0%}
                    <span>({%$detail.against%})</span>
                    {%else%}
                    <span></span>
                    {%/if%}
                </div>
            </div> -->
            <!-- 支付反对区域 end-->

            <!-- 新闻热搜 start-->
            {%if !empty($detail.tags)%}
            <div class="swiper-container hot-tags">
                <div class="swiper-wrapper">
                    <div class="swiper-slide tag-title">新闻热搜</div>
                    {%foreach from=$detail.tags item=hotItem name=hotItem%}
                        <div class="swiper-slide" dace-node="{%$id4dace%}_tag_{%$hotItem@index+1%}"><a href="{%$hotItem.url%}">{%$hotItem.tag_name%}</a></div>
                     {%/foreach%}
                </div>
            </div>
            {%/if%}

            <!-- 新闻热搜 end-->
        </section>

        {%widget
            name="news:widget/reply/reply.tpl"
        %}

        <div id="J_replyDownKanApp" class="down-kanApp fn-hide">
            <a href="http://mobile.hupu.com/download/games/?_r=mxinwenpinglun" class="down-link" dace-node="{%$id4dace%}_download-comment">下载虎扑体育App查看全部回复</a>
        </div>

        {%if isset($relation) && !empty($relation) && empty($username)%}
        <!-- 其他人正在看 –start -->
        <div class="guess-like">
            <div class="title">
                <h2>其他人正在看</h2>
            </div>
            <div class="bd">
                <ul class="list">
                    {%if !empty($kaluli) && isset($kaluli)%}
                        {%foreach from=$kaluli item=val name=key%}
                           <li>
                                <a href="{%$val.detail_url%}" dace-node="{%$id4dace%}_bbs">
                                    <h4 class="name">{%$val.title|escape:none%}</h4>
                                    <div class="status-bar">
                                        <div class="news-info">
                                            <span class="news-source">
                                                {%$val.come%}
                                            </span>
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
                    {%foreach from=$relation item=hotItem name=hotItem%}
                    <li>
                        <a href="{%$hotItem.link%}" dace-node="{%$id4dace%}_news">
                            <h4 class="name">{%$hotItem.title|escape:none%}</h4>
                            <div class="status-bar">
                                <div class="news-info">
                                    <span class="news-source">
                                        {%$hotItem.board%}
                                    </span>
                                </div>
                                {%if !empty($hotItem.replies)%}
                                <div class="news-comment">
                                    <i class="icon-comment"></i><span class="comment-number">{%$hotItem.replies%}</span>
                                </div>
                                {%/if%}
                            </div>
                        </a>
                    </li>
                    {%/foreach%}
                </ul>
            </div>
        </div>
        <!-- 其他人正在看 end -->
        {%/if%}
    </section>
    {%if $is_show_taobao|default:false%}
    <script src="//st1.shihuo.cn/alibtn.js" data-unit="px" data-style="right:-8" data-size="60" data-type="fixed" data-url="http://www.shihuo.cn/shihuo_activity_tmall_page.html"></script>
    {%/if%}
    <span style="display:none"></span>
{%/block%}

{%block name="footer"%}
    {%widget name="common:widget/footer/footer.tpl" footerType="newsdetail"%}
{%/block%}
