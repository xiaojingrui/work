
<form class="search-form" action="" method="get">
    {%if (!isset($smarty.get.fid) || $fid == 0) && empty($smarty.get.fromBBS) %}
        <select name="search" class="search-range select-sp">
            <option value="1" selected dace-node="{%$id4dace%}_searchall">全部</option>
        </select>
    {%elseif !empty($smarty.get.fromBBS) && empty($smarty.get.fid)%}
        <select name="search" class="search-range">
            <option value="1" dace-node="{%$id4dace%}_searchbyforum">专区</option>
            <option value="1" selected dace-node="{%$id4dace%}_searchall">全部</option>
        </select>
    {%else%}
        <select name="search" class="search-range">
            <option value="1" selected dace-node="{%$id4dace%}_searchbyforum">专区</option>
            <option value="1" dace-node="{%$id4dace%}_searchall">全部</option>
        </select>
    {%/if%}
    <div class="search-ipt">
        {%if !empty($smarty.get.keyword) %}
            <input type="text" class="has-icon" id="J_keyword" placeholder="" autocomplete="off" maxlength="18" value="{%$smarty.get.keyword|urldecode%}">
        {%else%}
            <input type="text" class="has-icon" id="J_keyword" placeholder="请输入搜索关键字" maxlength="18" autocomplete="off" >
        {%/if%}
        <em class="delete-icon"></em>
    </div>
    <input type="hidden" name="fid" value="">
    <input type="hidden" name="keyword" class="has-icon" id="J_keyword2" placeholder="" autocomplete="off" maxlength="18" value="">
    {%if !empty($smarty.get.fromBBS) %}
        <input type="hidden" name="fromBBS" value="{%$smarty.get.fromBBS%}">
    {%/if%}
    <input type="hidden" name="page" value="{%$searchData.page%}">
    <input class="search-btn" type="submit" value="搜索"  dace-node="{%$id4dace%}_5057">

</form>

{%script%}
    
    var selectTool = require("common:widget/ui/select/select.js");
    selectTool.init();
    
{%/script%}