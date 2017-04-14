{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/teams-schedule/teams-schedule.scss"%}

    {%script%}
        window.GM = {
            "en_name": "{%strtolower($teamInfo.eng_name)%}",
            "type": "team"
        }

        var nbaMatchList = require("common:widget/ui/nba-match-list/nba-match-list.js");
        nbaMatchList.init();

        var pageTool = require("common:widget/ui/page-tools/page-tools.js");
        pageTool.initTools({
            today: true,
            todayHandler: function(){
                var _top = $('.match-today').offset().top;
                $('html,body').scrollTop(_top);
            }
        });

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
    <section class="m-wrap teams-data-wrap">
        <!-- 球队信息 -->
        {%widget
            name="teams:widget/team-header/header.tpl"
        %}

        {%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="team"
            selected=2
        %}

        {%widget
            name="common:widget/ui/nba-match-list/nba-match-list.tpl"
            data=$schedule
        %}
    </section>
{%/block%}
