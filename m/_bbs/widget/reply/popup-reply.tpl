<script id="J_more_reply_template" type="text/template">
    <@ _.each(datas, function(item,index) { @>
    <dl class="reply-list J-reply-<@=item.pid@>">
        <dd class="operations-user">
            <div class="user-info">
                <div class="avatar">
                    <a href="/my/<@=item.authorid@>" dace-node="{%$id4dace%}_7100">
                        <img src="<@=item.header@>" alt=""/>
                    </a>
                </div>
                <a href="/my/<@=item.authorid@>" dace-node="{%$id4dace%}_7100" class="user-name"><@=item.author@></a>
                <@if(item.is_author==1||HPM.type==1){@>
                    <span class="reply-own">楼主</span>
                 <@}@>   
                <div class="user-other">
                    <@ if (item.floor) { @>
                        <span class="floor"><@=item.floor@>楼</span>
                    <@ } @>
                    <span class="times">
                        <@=item._postdate@>
                    </span>
                </div>
            </div>
            <div class="operations">
                <a href="javascript:" class="button-bright J_buttonBright" data-pid="<@=item.pid@>">
                    <span class="text">
                        亮了
                        <span class="bright-number-box">
                            <span class="J_brightNumber">(<@=item.light@>)</span>
                        </span>
                    </span>
                </a>
                <a href="javascript:" dace-node="{%$id4dace%}_quote" class="button-quote J_buttonQuote" data-pid="<@=item.pid@>" data-floor="
                    <@ if(item.floor) { @> <@=item.floor@> <@ }else{ @> 1 <@ } @>">
                    <span class="qoute-smail-content">
                        <@ if( !_.isEmpty(item.smallcontent) ) { @>
                            <@=item.smallcontent@>
                        <@ } @>
                    </span>
                    <span class="text">引用</span>
                </a>
            </div>
        </dd>

        <dt class="reply-content" dace-node="{%$id4dace%}_quote">
            <@ if( !_.isEmpty(item.quote) && _.isArray(item.quote) && item.quote.length > 0 ) { @>
                <div class="reply-quote-content J_contentParent">
                    <div class="reply-quote-hd">
                        <@=item.quote[0].header[0]@>
                        <@ if( !_.isEmpty(item.quote[0].togglecontent) ) { @>
                            <a href="javascript:" class="button-open J_buttonOpenAll" title="展开"></a>
                        }
                        <@ } @>
                    </div>
                    <@ if( !_.isEmpty( item.quote[0].togglecontent ) ) { @>
                        <div class="short-quote-content J_shortContent">
                            <@=item.quote[0].togglecontent@>
                        </div>
                        <div class="reply-quote-bd J_allContent">
                            <@=item.quote[0].content@>
                        </div>
                    <@ }else{ @>
                        <div class="short-quote-content">
                            <@=item.quote[0].content@>
                        </div>
                    <@ } @>
                </div>
            <@ } @>
            <div class="current-content J_contentParent J_currentContent">
                <span class="short-content">
                    <@=item.content@>
                </span>
            </div>
        </dt>

        <dd class="reply-bt">
            <span class="source-left">
                <@ if( !_.isEmpty(item.viainfo) ) { @>
                    <a href="<@=item.viainfo.url@>" class="source"><@=item.viainfo.text@></a>
                <@ } @>
            </span>
        </dd>
    </dl>
    <@ }); @>
</script>
