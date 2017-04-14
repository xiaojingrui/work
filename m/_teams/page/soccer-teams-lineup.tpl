{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/soccer-teams/lineup.scss"%}

    {%script%}
        var toShare = require("common:widget/ui/share/share.js");

        //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
            toShare();
        });

        //球员内页跳转.
        $(".teams-lineup").delegate("li","click", function(e){
            var target = $(e.currentTarget);
            var href = target.data("href");
            if(href){
                window.location.href = href;
            }
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
            name="teams:widget/soccer-team-header/header.tpl"
        %}

        {%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="soccer-team"
            selected=3
        %}
        <div class="main-content">

        {%$positions = [
             0 => "未知",
             1 => "门将",
             2 => "后卫",
             3 => "中场",
             4 => "前锋",
             5 => "替补",
             6 => "中锋",
             7 => "边后卫",
             8 => "中后卫",
             9 => "后腰",
             10 => "前腰",
             11 => "中前卫",
             12 => "影子前锋",
             13 => "边锋",
             14 => "翼卫"
        ]%}
        {%$positionColors = [
            1 => "#a4bd8e",
            2 => "#4591d1",
            3 => "#ff6022",
            4 => "#c80c00"
        ]%}
        {%$players=[]%}
        {%foreach $playerInfo as $player%}
            {%if !empty($player.position)%}
                {%if empty($players[$player.position])%}
                    {%$players[$player.position] = []%}
                {%/if%}

                {%if empty($player.known_name)%}
                    {%if empty($player.name)%}
                        {%if empty($player.known_name_en)%}
                            {%$player.known_name=$player.name_en%}
                        {%else%}
                            {%$player.known_name=$player.known_name_en%}
                        {%/if%}
                    {%else%}
                        {%$player.known_name=$player.name%}
                    {%/if%}
                {%/if%}

                {%$tmp = array_push($players[$player.position], $player)%}
            {%/if%}
        {%/foreach%}
        <ul class="teams-lineup">
            <li>
                <span>球员</span>
                <span>年龄</span>
                <span class="w1">国籍</span>
                <span>号码</span>
            </li>
            {%foreach from=[1,2,3,4] item=pos%}
                <li class="teams-position">
                    <h3 style="background-color:{%$positionColors[$pos]%}">{%$positions[$pos]%}</h3>
                </li>
                {%foreach $players[$pos] as $player%}
                <li data-href="{%$player.player_url%}">
                    <span>{%$player.known_name%}</span>
                    <span>{%calc_age birth=$player.birth_date%}</span>
                    <span class="w1">{%$player.country|default:"--"%}</span>
                    <span>{%$player.jersey_num|default:"--"%}</span>
                </li>
                {%/foreach%}
            {%/foreach%}
        </ul>
        </div>
    </section>
{%/block%}
