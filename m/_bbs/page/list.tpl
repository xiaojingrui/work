{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="bbs:static/list/list.scss"%}
    {%require name="bbs:static/list/list.js"%}
    <script>
    !function(win){
        // 用于发贴
        HPM.fid = '{%$fid%}' || '';
        // 总分页数
        HPM.pageCount = parseInt('{%$pageCount%}') || 0;
        // 当前板块链接
        HPM.boardLink = '/bbs/{%$fid%}';
        HPM.hotForums = {%json_encode($hotForums)%}||[];
        HPM.collectedForums = {%json_encode($collectedForums)%}||[];
    }(window);

    </script>
    {%script%}

        var islogin = HPM.isLogin;

        var tools = require("common:widget/ui/page-tools/page-tools.js");
        tools.initTools({
            post : true,
            postHandler: function(e){
                e.preventDefault();
                var target = $(e.target);
                var href = target.attr("href");
                if(islogin){
                    location.href = href;
                } else{
                    HPM.popLogin();
                }
            }
        });

        var board = require("bbs:widget/recommendBoard/recommendBoard.js");
        board({
            isIndex: false,
            isLogin: islogin
        });
    {%/script%}
{%/block%}

{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=true
        hasUserTools=true
    %}

    <section class="list-wrap">
        <div class="bbs-title">
            <h3>{%$forumName%}</h3>
            {%if $_islogin && $isCollected%}
            <a href="javascript:;" class="focus ing">已关注</a>
            {%else%}
            <a href="javascript:;" class="focus" dace-node="{%$id4dace%}_attention">+关注</a>
            {%/if%}


            <div class="rank-div">
                {%if empty($smarty.get.postdate) %}
                <a href="{%$baseurl%}/bbs/{%$fid%}-{%$page%}?postdate=1" class="rank-btn" dace-node="{%$id4dace%}_orderbynew">按发帖时间排序<!--<i class="icon icon-sequence"></i>--></a>
                {%else%}
                <a href="{%$baseurl%}/bbs/{%$fid%}-{%$page%}" class="rank-btn" dace-node="{%$id4dace%}_oderbyreply">按回帖时间排序<!--<i class="icon icon-sequence"></i>--></a>
                {%/if%}
            </div>
        </div>

        {%widget
            name = "common:widget/ui/bbs-list/bbs-list.tpl"
            data = $posts
            boardData = $recommendBoard
            curPage = $page
            forumName = $forumName
        %}
    </section>
    {%if !empty($smarty.get.postdate)%}
        {%$postdate = '?postdate=1'%}
    {%else%}
        {%$postdate = ''%}
    {%/if%}
    {%widget name="common:widget/ui/page/page.tpl" pageCount=$pageCount page=$page urlBase="/bbs/{%$fid%}-#{page}$postdate"%}

{%/block%}

{%block name="footer"%}
    {%widget
        name="common:widget/footer/footer.tpl"
        footerType="bbs"
        footerPage="bbsList"
    %}
{%/block%}
