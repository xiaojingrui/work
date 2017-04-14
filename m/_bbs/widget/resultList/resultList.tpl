<div class="common-list news-list">
    {%if !empty($data)%}
    <ul>
        {%foreach from=$data item=val name=key%}
            {%if !empty($val.subject)%}
            <li>
                <a href="{%$val.url%}" dace-node="{%$id4dace%}_5051">
                    <div class="news-link">
                        <div class="news-txt">
                            <h3> {%$val.subject|escape:none%}</h3>
                            <div class="news-status-bar">
                                <div class="news-info">
                                    <span class="news-source">{%$val.author%}</span>
                                    <span class="news-time">{%$val.date%}</span>
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
            {%/if%}
        {%/foreach%}
    </ul>
    {%/if%}
</div>


<script id="list-template" type="text/template">
    <@ _.each(datas, function(item,index) { @>
        <li>
            <a href="<@=item.url@>" dace-node="<@=id4dace@>_5051">
                <div class="news-link">
                    <div class="news-txt">
                        <h3><@=item.subject@></h3>
                        <div class="news-status-bar">
                            <div class="news-info">
                                <span class="news-source"><@=item.author@></span>
                                <span class="news-time"><@=item.date@></span>
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
