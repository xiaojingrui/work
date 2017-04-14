{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/players-game/game-data.scss"%}

    {%script%}
        var toShare = require("common:widget/ui/share/share.js");

        //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
        toShare();
        });
    {%/script%}
{%/block%}
{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=false
    %}
    
    {%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}
    <section class="m-wrap playersGameData-wrap">
        <!-- 球队信息 -->
        {%widget
            name="teams:widget/soccer-player-header/header.tpl"
        %}

        {%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="soccer-players"
            selected=3
        %}


    </section>
{%/block%}
