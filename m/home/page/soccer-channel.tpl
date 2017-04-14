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
    <section class="nba-wrap">
        {%if !empty($customSoccer["home_diy"])%}
            <!-- 自定义内容 start -->
            {%widget
                name="home:widget/card-1/card.tpl"
                data=$customSoccer["home_diy"]
                dace="{%$id4dace%}_operate"
                isTopline = true
            %}
            <!-- 自定义内容 end -->
        {%/if%}

            {%widget
                name="home:widget/match-board/match-board.tpl"
                data=$gameList
            %}
        {%if !empty($customSoccer["home_diy"])%}
            <!-- 自定义内容 start -->
            {%widget
                name="home:widget/card-1/card.tpl"
                data=$customSoccer["home_diy"]
                dace="{%$id4dace%}_operate"
            %}

            <!-- 自定义内容 end -->
        {%/if%}


        <!-- 新闻10条 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            dace="{%$id4dace%}_hupuProduct"
            data=$homeData["news"]
        %}
        <!-- 新闻10条 end -->

        <!-- 帖子5条 start -->
        {%widget
            name="home:widget/card-2/card.tpl"
            banner=$homeData["bbs"]["name"]
            dace="{%$id4dace%}_soccerHeadlines"
            data=$homeData["bbs"]["data"]
            link=$homeData["bbs"]["url"]
            type="soccer"
        %}
        <!-- 帖子5条 end -->

        <!-- 专区 start -->
        {%if !empty($homeData["teamBbs"]) %}
        {%foreach $homeData["teamBbs"] as $item%}
            {%widget
                name="home:widget/card-2/card.tpl"
                banner=$item["name"]
                dace="{%$id4dace%}_{%$item.fid%}"
                data=$item["data"]
                link=$item["url"]
                type="soccer"
            %}
        {%/foreach%}
        {%/if%}
        <!-- 专区 end -->

    </section>
{%/block%}

{%block name="footer"%}
    {%widget name="common:widget/footer/footer.tpl" footerType="index"%}
{%/block%}
