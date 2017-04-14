{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/players/soccer-players.css"%}

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
        {%if !empty($playerInfo)%}
            <!-- 球队信息 -->
            {%widget
                name="teams:widget/soccer-player-header/header.tpl"
            %}

            {%widget
                name="common:widget/inner-tab/tab.tpl"
                tabClass="soccer-players"
                selected=1
            %}

            {%$foot = [
                "0" => "未知",
                "1" => "左脚",
                "2" => "右脚",
                "3" => "双脚"
            ]%}

            <div class="season-content technical-content">
                <div class="table-scroll">
                    <table class="table table-3">
                        <tbody>
                            <tr>
                                <td class="number-1">身高</td>
                                <td class="number-2">{%$playerInfo.height/100|string_format:"%.2f"%}米</td>
                            </tr>
                            <tr>
                                <td class="number-1">体重</td>
                                <td class="number-2">{%$playerInfo.weight%}公斤</td>
                            </tr>
                            <tr>
                                <td class="number-1">球队</td>
                                <td class="number-2">{%$playerInfo.team_name%}</td>
                            </tr>
                            <tr>
                                <td class="number-1">生日</td>
                                <td class="number-2">{%$playerInfo.birth_date%}&nbsp;|&nbsp;{%$playerInfo.age%}岁</td>
                            </tr>
                            <tr>
                                <td class="number-1">国籍</td>
                                <td class="number-2">{%$playerInfo.country%}</td>
                            </tr>
                            <tr>
                                <td class="number-1">惯用脚</td>
                                <td class="number-2">{%$foot[$playerInfo.preferred_foot]%}</td>
                            </tr>
                            {%if $playerInfo["worth"]%}
                            <tr>
                                <td class="number-1">身价</td>
                                <td class="number-2">€{%$playerInfo["worth"]%}万</td>
                            </tr>
                            {%/if%}
                        </tbody>
                    </table>
                </div>
            </div>
        {%else%}
            <div class="season-content technical-content">
                <div class="noresult">暂无数据</div>
            </div>
        {%/if%}
    </section>
{%/block%}
