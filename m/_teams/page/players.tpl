{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/players/players.scss"%}

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
    <section class="m-wrap players-wrap">
        <!-- 球队信息 -->
        {%widget
            name="teams:widget/team-header/header.tpl"
        %}

        {%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="team"
            selected=3
        %}

        <div class="main-content">
            <div class="players-list">
                <ul class="list">
                    {%foreach from=$players item=val name=key%}
                        <li>
                            <a href="{%$val.player_link%}" dace-node="{%$id4dace%}_player">
                                <dl>
                                    <dd class="avatar">
                                        <img src="{%$val.photo_link%}" alt=""/>
                                    </dd>
                                    <dt class="name">
                                        {%$val.alias%}
                                    </dt>
                                    <dd class="age">
                                        {%$val.number%} {%$val.positionZhName%}
                                    </dd>
                                    <dd class="annual-salary">
                                        {%$val.final_field%}
                                    </dd>
                                </dl>
                            </a>
                        </li>
                    {%/foreach%}
                </ul>
            </div>
        </div>
    </section>
{%/block%}
