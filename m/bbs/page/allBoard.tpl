{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="bbs:static/allBoard/allBoard.scss"%}
    {%require name="bbs:static/allBoard/allBoard.js"%}


    <script>
        !(function (doc, win) {
            // 总分页数
            HPM.pageCount = 10;
            HPM.isIndex = 1;
            HPM.hotForums = {%json_encode($hotForums)%}||[];
            HPM.collectedForums = {%json_encode($collectedForums)%}||[];
        })(document, window);

    </script>

{%/block%}
{%block name="content"%}
    {%widget
        name="common:widget/top-title/top-title.tpl"
        banner="全部版块"
        titleCenter="left"
    %}
    <div class="allBoard-wrap">
        <div class="sidebar">
            <ul>
                {%if !empty($bbsnav) %}
                    <!-- 收藏 -->
                    {%if $_islogin%}
                        <li class="">我的版块</li>
                    {%else%}
                        <li class="">热门版块</li>
                    {%/if%}
                    {%foreach from=$bbsnav item=val name=key%}
                        <li data-fid="{%$val.hotfid%}">{%$val.name%}</li>
                    {%/foreach%}
                {%/if%}
            </ul>
        </div>
        <div class="board-wrapper">
            <!-- 收藏 -->
            {%if $_islogin%}
                <div class="board-list" dace-node="{%$id4dace%}_5050_fav" section-exposure="{%$id4dace%}_showfav">
                    {%if !empty($myCollectedForums)%}
                        <ul>
                           {%foreach from=$myCollectedForums item=val name=key%}
                                <li>
                                    <a href="{%$val.forumindex%}">{%$val.name%}</a>
                                    {%if $val.todayAddNum%}<i>{%$val.todayAddNum%}&nbsp;帖</i>{%/if%}
                                </li>
                           {%/foreach%}
                        </ul>
                    {%else%}
                        <div class="not-list">
                            暂无收藏
                        </div>
                    {%/if%}
                </div>
            {%else%}
                <div class="board-list" dace-node="{%$id4dace%}_5050_fav" section-exposure="{%$id4dace%}_showfav">
                    <ul>
                       {%foreach from=$hotNav item=val name=key%}
                            <li>
                                <a href="{%$val.forumindex%}">{%$val.name%}</a>
                                {%if $val.todayAddNum%}<i>{%$val.todayAddNum%}&nbsp;帖</i>{%/if%}
                            </li>
                       {%/foreach%}
                    </ul>
                </div>
            {%/if%}
            {%foreach from=$bbsnav item=val name=key%}
                <div class="board-list">
                    <ul>
                       {%foreach from=$val.forums item=valInner name=key%}
                            <li data-fid="{%$valInner.fid%}"><a href="{%$valInner.url%}" dace-node="{%$id4dace%}_{%$val.name%}_{%$valInner.name%}">{%$valInner.name%}</a><i></i></li>
                        {%/foreach%}
                    </ul>
                </div>
            {%/foreach%}
        </div>
    </div>
{%/block%}
