{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="common:static/js/zepto/animate.js"%}
    {%require name="bbs:static/list/list.scss"%}
    <script>
        // !function(win){
        //     // 总分页数
        //     HPM.pageCount = 10;
        //     HPM.isIndex = 1;
        //     HPM.hotForums = {%json_encode($hotForums)%}||[];
        //     HPM.collectedForums = {%json_encode($collectedForums)%}||[];
        // }(window);
    </script>
    {%*****
    {%script%}
        var board = require("bbs:widget/recommendBoard/recommendBoard.js");
        board({
            isIndex: true,
            isLogin: HPM.isLogin
        });
    {%/script%}
    *%}
{%/block%}

{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=true
        hasUserTools=true
        fromPage="index"
    %}
    <section class="list-wrap">
        {%widget
            name="bbs:widget/board-list/board-list.tpl"
        %}
    </section>
{%/block%}

{%block name="footer"%}
    {%widget name="common:widget/footer/footer.tpl" footerType="bbs" footerPage="bbs"%}
{%/block%}
