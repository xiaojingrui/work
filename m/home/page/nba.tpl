{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="home:static/nba/index.scss"%}
{%/block%}

{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=true
    %}
    <section class="nba-wrap">

        <!-- 自定义内容 start -->
        {%if isset($customNba["home_diy"]) && !empty($customNba["home_diy"])%}
            {%widget
                name="home:widget/card-1/card.tpl"
                data=$customNba["home_diy"]
                dace="{%$id4dace%}_operate"
                isTopline = true
            %}
        {%/if%}
        <!-- 自定义内容 end -->
            {%widget
                name="home:widget/match-board/match-board.tpl"
                data=$gameList
            %}


        <!-- 自定义内容 start -->
        {%if isset($customNba["home_diy"]) && !empty($customNba["home_diy"])%}
            {%widget
                name="home:widget/card-1/card.tpl"
                dace="{%$id4dace%}_operate"
                data=$customNba["home_diy"]
            %}
        {%/if%}
        <!-- 自定义内容 end -->
        <div class="card-4-wrap">
        <!-- 头条 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            dace="{%$id4dace%}_nbaHeadlines"
            data=$homeData["nba"]
        %}
        <!-- 头条 end -->

        <!-- NBA头条下方文字流广告 -->
        {%widget
            name="common:widget/card-ad/card-ad.tpl"
            data=$adInfo.m_adword.nba_home_top
        %}

        <!-- 虎扑制造 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            dace="{%$id4dace%}_hupuProduct"
            data=$homeData["zhizao"]
        %}
        <!-- 虎扑制造 end -->

        <!-- 湿乎乎话题区 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner="湿乎乎话题区"
            showFrom=true
            dace="{%$id4dace%}_bbs"
            sectionExposure="{%$id4dace%}_show1048"
            data=$homeData["topic"]
        %}
        <!-- 湿乎乎话题区 end -->

        <!-- 最热NBA新闻 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner="最热NBA新闻"
            dace="{%$id4dace%}_hotNews"
            sectionExposure="{%$id4dace%}_showhotnews"
            data=$homeData["hotnews"]
        %}
        <!-- 最热NBA新闻 end -->

        <!-- bbs专区 start -->
        {%foreach from=$homeData.teams item=val key=keys %}
            {%if isset($adInfo.m_partner.m_nba_home_rockets_upside.adcode) && $val[0]["boardname"] == "火箭专区"%}
                <section class="card-col-4" id="u2740416">
                    {%$adInfo.m_partner.m_nba_home_rockets_upside.adcode|escape:none%}
                </section>
            {%/if%}
            {%widget
                name="home:widget/card-2/card.tpl"
                banner="{%$val[0]["boardname"]%}"
                showFrom=true
                dace="{%$id4dace%}_nbaPlate"
                data=$val
            %}
        {%/foreach%}
        <!-- bbs专区 end -->

        <!-- bbs专区下方文字流广告 -->
        {%widget
            name="common:widget/card-ad/card-ad.tpl"
            data=$adInfo.m_adword.nba_home_lakers
            pos="bottom"
        %}
        <!-- bbs专区下方文字流广告 end -->
        </div>
    </section>
{%/block%}

{%block name="footer"%}
    {%widget name="common:widget/footer/footer.tpl" footerType="index"%}
{%/block%}
