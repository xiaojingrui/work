{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="bbs:static/search/search.scss"%}
    {%require name="bbs:static/list/list.scss"%}
    {%require name="bbs:static/search/search.js"%}

    
    <script>
    !function(win){
        // 当前板块ID 做链接用
        HPM.fid = '{%$searchData.fid%}' || '';
        // 总分页数
        HPM.pageCount = parseInt('{%$searchData.pageCount%}') || 0;
        // 判断是否为首页
        HPM.isIndex = 0;
        // 当前板块名称
        HPM.boardName = '{%$forumName%}';
        // 当前板块链接
        HPM.boardLink = '/bbs/{%$fid%}';
        HPM.hotForums = {%json_encode($hotForums)%}||[];
        HPM.collectedForums = {%json_encode($collectedForums)%}||[];
    }(window);

    </script>
{%/block%}

{%block name="content"%}
    <header class="search-header">
        <a href="javascript:window.history.go(-1)"><em></em></a><h3>搜索</h3>
    </header>
    <div class="search-wrap">
        {%widget
            name = "common:widget/ui/select/select.tpl"
            fid  = $searchData.fid
        %}
    </div>
    {%if !empty($searchData.error)%}
        <div class="error-tips">
            {%$searchData.error%}
        </div>
    {%else%}
        <section class="list-wrap searchRes-list">
            <div class="bbs-title bbs-title-sp">
                <h3>全部{%$searchData.allnum%}个结果</h3>
                <!-- 
                <div class="rank-div">
                    {%if !empty($smarty.get.sort) %}
                        <a href="#" class="rank-btn">按发帖时间倒序排列<i class="icon icon-sequence"></i></a>
                    {%else%}
                        <a href="#" class="rank-btn asc">按发帖时间正序排列<i class="icon icon-sequence1"></i></a>
                    {%/if%}
                </div>
                -->
            </div>
            {%widget
                name = "bbs:widget/resultList/resultList.tpl"
                data = $searchData.data
            %}
        </section>
    {%/if%}
    {%$keyword = $smarty.get.keyword%}
    {%$fid = $smarty.get.fid%}
    {%$sort = $smarty.get.sort%}
    {%widget name="common:widget/ui/page/page.tpl" pageCount=$searchData.pageCount page=$searchData.page urlBase="/bbs/searchthreads?search=1&keyword=$keyword&fid=$fid&sort=$sort&page=#{page}"%}

{%/block%}