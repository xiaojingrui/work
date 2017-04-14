{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="home:static/nba/index.scss"%}
    {%require name="home:static/nba-tieba/nba-tieba.scss"%}
{%/block%}

{%block name="content"%}

    <section class="nba-wrap">

        <!-- 自定义内容 start -->
        {%if isset($customNba["home_diy"]) && !empty($customNba["home_diy"])%}
            {%widget
                name="home:widget/card-1/card.tpl"
                data=$customNba["home_diy"]
                fromurl=$from
                dace="{%$id4dace%}_operate"
                isTopline = true
            %}
        {%/if%}
        <!-- 自定义内容 end -->

        <!-- 自定义内容 start -->
        {%if isset($customNba["home_diy"]) && !empty($customNba["home_diy"])%}
            {%widget
                name="home:widget/card-1/card.tpl"
                dace="{%$id4dace%}_operate"
                data=$customNba["home_diy"]
                fromurl=$from
            %}
        {%/if%}
        <!-- 自定义内容 end -->
        <div class="card-4-wrap">
            <!-- 最热NBA新闻 start -->
            {%widget
                name="home:widget/card-2/card.tpl"
                banner="最热NBA新闻"
                dace="{%$id4dace%}_hotNews"
                sectionExposure="{%$id4dace%}_showhotnews"
                data=$homeData
            %}
            <!-- 最热NBA新闻 end -->
        </div>
    </section>
{%/block%}

{%block name="footer"%}

{%/block%}