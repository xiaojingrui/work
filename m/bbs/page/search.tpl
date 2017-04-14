{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="bbs:static/search/search.scss"%}
    {%require name="bbs:static/search/search.js"%}
    
    {%script%}
        HPM.isSearchIndex = 1; 
        HPM.uid = '{%$uid%}';       
    {%/script%}
    
    
{%/block%}

{%block name="content"%}
    <header class="search-header">
        <a href="{%$node[0].url%}"><em></em></a><h3>搜索</h3>
    </header>
    <div class="search-wrap">
        {%widget
            name = "common:widget/ui/select/select.tpl"
            fid  = $searchData.fid
        %}
        
        {%if $_islogin && !empty($searchData.history)%}
        <div class="recent-search" section-exposure="{%$id4dace%}_showhistory">
            <div class="title">
                <h3>最近搜索</h3>
                <em class="delete-icon" id="J_rmHistory" dace-node="{%$id4dace%}_deleterecord"></em>
            </div>
            <ul class="recent-search-list" dace-node="{%$id4dace%}_record">
                {%foreach from=$searchData.history item=val name=key%}
                    <li>{%$val%}</li>
                {%/foreach%}
            </ul>
        </div>
        {%/if%}
        
    </div>

{%/block%}

{%block name="footer"%}
{%/block%}