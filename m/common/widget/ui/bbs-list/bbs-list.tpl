{%$name = ""%}
{%$turl = ""%}

{%if isset($className)%}
    {%$name = "$className"%}
{%/if%}

<div class="common-list news-list {%$name%}">
    <ul>
        {%foreach from=$data item=val name=key%}
            {%if !empty($val.turl)%}
                {%$turl = $val.turl%}
            {%else%}
                {%$turl = $val.mobileurl%}
            {%/if%}
            {%if !empty($from) && $from == "bbsindex" && $val@index == 10%}
                {%widget
                    name="common:widget/card-ad/card-ad.tpl"
                    data=$adInfo.m_adword.bbs_home
                    from=$from
                %}
            {%/if%}

            <li {%if $val.overviewimg|count > 1 %}class="figure-li"{%/if%} {%if isset($collect) && $val.tid %}data-tid="{%$val.tid%}"{%/if%}>
                <a href="{%$turl%}" dace-node="{%$id4dace%}_bbs">
                    <div class="news-link">
                        <div class="news-txt">
                            <h3>{%$val.subject%}</h3>
                            <div class="news-status-bar">
                                    <div class="news-time">
                                        {%if empty($smarty.get.postdate) %}
                                            {%$val._lastpost%}
                                        {%else%}
                                            {%$val._postdata%}
                                        {%/if%}
                                    </div>
                                    <div class="news-source">
                                        {%if isset($val.username)%}
                                            {%$val.username%}
                                        {%else%}
                                            {%$val.boardname%}
                                        {%/if%}
                                    </div>
                                
                                {%if !empty($val.replies)%}
                                    <div class="news-view">
                                        {%if !empty($val.lights)%}
                                        <i class="icon-bright"></i>
                                        <span class="bright-no">{%$val.lights%}</span>
                                        {%/if%}
                                        <i class="icon-comment"></i>
                                        <span>{%$val.replies%}</span>
                                    </div>
                                {%/if%}
                            </div>
                        </div>
                    </div>
                </a>
            </li>
        {%/foreach%}
    </ul>
</div>


<script id="list-template" type="text/template">
    <@ _.each(datas, function(item,index) { @>
        <li <@ if( item.overviewimg.length > 1 ) { @>class="figure-li"<@ } @>>
            <@ if( item.turl > 0 ) { @>
                <a href="<@=item.turl@>">
            <@ else @>
                <a href="<@=item.mobileurl@>">
            <@ } @>
                    <div class="news-link">
                        <div class="news-txt">
                            <h3><@=item.subject@></h3>
                            <@ if( item.overviewimg.length > 1 ) { @>
                            <div class="figure-list">
                                <@ _.each(item.overviewimg, function(item1,index1) { @>
                                <span style="background-image: url(<@=item1@>);"></span>
                                <@ }); @>
                            </div>
                            <@ } @>
                            <div class="news-status-bar">
                                <div class="news-info">
                                    <span class="news-source"><@=item.username@></span>
                                    <span class="news-time"><@=item._lastpost@></span>
                                </div>
                                <@ if( item.replies > 0 ) { @>
                                <div class="news-view">
                                     <@ if( item.lights > 0 ) { @>
                                     <i class="icon-bright"></i><span class="bright-no"><@=item.lights@></span>
                                     <@ } @>
                                     <i class="icon-comment"></i><span><@=item.replies@></span></div>
                                <@ } @>
                            </div>
                        </div>

                    </div>
                </a>
        </li>
    <@ }); @>
</script>
