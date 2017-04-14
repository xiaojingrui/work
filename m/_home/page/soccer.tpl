{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="home:static/nba/index.scss"%}
{%/block%}
{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasMidNav=true
        hasBreadNav=true
    %}

        {%widget
            name="home:widget/match-board/match-board.tpl"
            data=$gamelist
            from="index"
        %}
    <section class="nba-wrap">
        <!-- 自定义内容 start -->
        {%widget
            name="home:widget/card-1/card.tpl"
            data=$customSoccer["home_diy"]
            dace="{%$id4dace%}_operate"
            isTopline = true
        %}
        <!-- 自定义内容 end -->


        <!-- 自定义内容 start -->
        {%widget
            name="home:widget/card-1/card.tpl"
            data=$customSoccer["home_diy"]
            dace="{%$id4dace%}_operate"
        %}

        <!-- 自定义内容 end -->

        <!-- 头条 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            dace="{%$id4dace%}_soccerHeadlines"
            data=$homeData["soccer"]
        %}
        <!-- 头条 end -->

        <!-- 头条下方文字流广告 -->
        {%widget
            name="common:widget/card-ad/card-ad.tpl"
            data=$adInfo.m_adword.soccer_home_top
        %}

        <!-- 虎扑制造 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            dace="{%$id4dace%}_hupuProduct"
            data=$homeData["zhizao"]
            type="soccer"
        %}
        <!-- 虎扑制造 end -->

        <!-- 中超头条 start -->

        <!-- 中超头条 end -->
        {%**widget
            name="home:widget/card-2/card.tpl"
            banner="中超头条"
            dace="{%$id4dace%}_china"
            data=$homeData["china"]
        **%}

        <!-- 足球话题区 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner="足球话题区"
            hideForm=true
            dace="{%$id4dace%}_bbs"
            sectionExposure="{%$id4dace%}_show1389"
            data=$homeData["huati"]
        %}
        <!-- 足球话题区 end -->

        <!-- 最热足球新闻 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner="最热足球新闻"
            dace="{%$id4dace%}_hotNews"
            sectionExposure="{%$id4dace%}_showhotnews"
            data=$homeData["hotnews"]
        %}
        <!-- 最热足球新闻 end -->

        {%if isset($adInfo.m_partner.m_soccer_home_epl_upside.adcode)%}
        <section class="card-col-4" id="u2740431">
            {%$adInfo.m_partner.m_soccer_home_epl_upside.adcode|escape:none%}
        </section>
        {%/if%}

        <!-- 英超专区 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner="英超"
            hideForm=true
            dace="{%$id4dace%}_eng"
            data=$homeData["eng"]
        %}
        <!-- <p class="region-link"><a href="{%$engnewsurl%}">去英超专区看看 >></a></p> -->

        <!-- 英超专区 end -->

        <!-- 西甲专区 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner="西甲"
            hideForm=true
            dace="{%$id4dace%}_esp"
            data=$homeData["esp"]
        %}
        <!-- <p class="region-link"><a href="{%$espnewsurl%}">去西甲专区看看 >></a></p> -->

        <!-- 西甲专区 end -->

        <!-- 西甲专区 下方文字流广告 -->
        {%widget
            name="common:widget/card-ad/card-ad.tpl"
            data=$adInfo.m_adword.soccer_home_laliga
            pos="bottom"
        %}

        <!-- 德甲专区 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner="德甲"
            hideForm=true
            dace="{%$id4dace%}_germ"
            data=$homeData["germ"]
        %}
        <!-- <p class="region-link"><a href="{%$iltnewsurl%}">去德甲专区看看 >></a></p> -->
        <!-- 德甲专区 end -->

        <!-- 意甲专区 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner="意甲"
            hideForm=true
            dace="{%$id4dace%}_itl"
            data=$homeData["itl"]
        %}
        <!-- <p class="region-link"><a href="{%$iltnewsurl%}">去意甲专区看看 >></a></p> -->
        <!-- 意甲专区 end -->
    </section>
{%/block%}

{%block name="footer"%}
    {%widget name="common:widget/footer/footer.tpl" footerType="index"%}
{%/block%}
