{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="home:static/index/index.scss"%}
{%/block%}

{%block name="content"%}
    {%widget
        name="common:widget/top-nav/top-nav.tpl"
        channel="sports"
        isTwoNav=true
    %}

    {%if !empty($custom["m_forcus"])%}
        {%widget
            name="home:widget/card-slide/slide.tpl"
            block="page_index_top"
            data=$custom["m_forcus"]
        %}
    {%/if%}

    <section class="index-wrap" dace-node="{%$id4dace%}_game">
        {%widget
            name="home:widget/match-board/match-board.tpl"
            data=$gameList
            from="index"
        %}


        {%if !empty($custom["home_diy"])%}
        <div class="home-diy {%if $isPredict%}hasPredict{%/if%}">
        <!-- 自定义内容 start -->
        {%widget
            name="home:widget/card-1/card.tpl"
            data=$custom["home_diy"]
            dace="{%$id4dace%}_operate"
            isTopline=true
        %}

        <!-- 自定义内容2 start -->
        {%widget
            name="home:widget/card-1/card.tpl"
            data=$custom["home_diy"]
            dace="{%$id4dace%}_operate"
        %}
        </div>
        {%/if%}

        <!-- 篮球头条 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner="篮球"
            dace="{%$id4dace%}_nbaHeadlines"
            sectionExposure="{%$id4dace%}_shownba"
            data=$homeData["nba"]
            link = $homeDataUrl["nba"]
        %}

        <!-- 首页NBA下方文字流广告 -->
        {%widget
            name="common:widget/card-ad/card-ad.tpl"
            data=$adInfo.m_adword.m_home_nba
        %}

        {%if isset($adInfo.m_partner.m_home_soccer_upside.adcode)%}
        <section class="card-col-4" id="u2740429">
            {%$adInfo.m_partner.m_home_soccer_upside.adcode|escape:none%}
        </section>
        {%/if%}

        <!-- 足球头条 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner="足球"
            dace="{%$id4dace%}_soccerHeadlines"
            sectionExposure="{%$id4dace%}_showsoccer"
            data=$homeData["soccer"]
            link = $homeDataUrl["soccer"]
        %}

        <!-- 步行街 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner="步行街"
            dace="{%$id4dace%}_buxingjie"
            sectionExposure="{%$id4dace%}_show34"
            data=$homeData["bxj"]
            link = $homeDataUrl["bxj"]
        %}

        <!-- F1头条 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner="赛车"
            dace="{%$id4dace%}_f1Headlines"
            data=$homeData["f1"]
            link = $homeDataUrl["f1"]
        %}

        <!-- 首页网球下方文字流广告 -->
        {%widget
            name="common:widget/card-ad/card-ad.tpl"
            data=$adInfo.m_adword.m_home_tennis
            pos="bottom"
        %}

         <!-- 识货 start -->
        {%widget
            name="home:widget/card-3/card.tpl"
            banner="识货"
            dace="{%$id4dace%}_shihuoSku"
            isBigShow="true"
            data=$shihuo
            link = $homeDataUrl["shihuo"]
        %}
        <!-- 卡路里 -->
         {%widget
            name="home:widget/card-4/card.tpl"
            banner="卡路里运动营养"
            dace="{%$id4dace%}_kaluli"
            data=$kaluli
            link = $homeDataUrl["kaluli"]
        %}

         <!-- 游戏 start -->
        {%if !empty($homeGameData)%}
        <section class="card-col-4" dace-node="{%$id4dace%}_game" section-exposure="{%$id4dace%}_showyouxi">
        <div class="card-wrap">
        <article class="title">
            <h2>游戏</h2>
        </article>
        <article class="bd">
            <ul class="card-game">
                {%foreach $homeGameData as $game%}
                    <li>
                        <a href="{%$game.link%}" title="{%$game.name%}">
                            <img alt="{%$game.name%}" src="{%$game.logo%}" dace-node="{%$id4dace%}_youxi_{%$game@index%}"/>
                            <p>{%$game.name%}</p>
                        </a>
                    </li>
                {%/foreach%}
            </ul>
        </article>
        <article class="more-relative-info">
                    <a href="{%$homeDataUrl['youxi']%}">
                        <span>进入游戏查看更多</span>
                    </a>
                </article>
         </section>
        {%/if%}
    </section>

{%/block%}
{%block name="footer"%}
    {%widget name="common:widget/footer/footer.tpl" footerType="home"%}
{%/block%}
