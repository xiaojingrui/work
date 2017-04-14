<script id="more-reply-template" type="text/template">
    <@ _.each(datas, function(item,index) { @>
    <dl class="reply-list">
        <dd class="operations-user">
            <div class="wrap">
                <div class="user-name">
                    <a dace-node="{%$id4dace%}_home" href="/my/<@=item.uid@>"><@=item.user@></a>
                </div>
                <div class="time"><@=item.time@></div>
            </div>
            <div class="operations">
                <a href="javascript:" class="button-bright J_buttonBright" data-pid="<@=item.id@>" data-uid="<@=item.uid@>">
                    <@ if( !_.isEmpty( item.light ) ) { @>
                    <span class="text">亮了</span><span class="bright-number-box">(<span class="J_brightNumber"><@=item.light@></span>)</span>
                    <@ }else{ @>
                    <span class="text">亮了</span><span class="bright-number-box">(<span class="J_brightNumber">0</span>)</span>
                    <@ } @>
                </a>
                <a href="javascript:" dace-node="{%$id4dace%}_quote" class="button-quote J_buttonQuote" data-pid="<@=item.id@>" data-floor="<@=item.floor@>">
                    <span class="qoute-smail-content"><@=item.smallcontent@></span>
                    <span class="text">引用</span>
                </a>
            </div>
        </dd>
        <dt class="reply-content">
            <@ if( !_.isEmpty( item.quote ) ) { @>
        <div class="reply-quote-content J_contentParent">
            <div class="reply-quote-hd">
                <@=item.quote.header@>
                <@ if( !_.isEmpty( item.quote.togglecontent ) ) { @>
                <a href="javascript:" class="button-open J_buttonOpenAll" title="展开"></a>
                <@ } @>
            </div>
            <@ if( !_.isEmpty( item.quote.togglecontent ) ) { @>
            <div class="short-quote-content J_shortContent">
                <@=item.quote.togglecontent@>
            </div>
            <div class="reply-quote-bd J_allContent">
                <@=item.quote.content@>
            </div>
            <@ }else{ @>
            <div class="short-quote-content">
                <@=item.quote.content@>
            </div>
            <@ } @>
        </div>
        <@ } @>
        <div class="current-content J_contentParent">
            <span class="short-content">
                <@=item.content@>
            </span>
        </div>
        </dt>
    </dl>
    <@ }); @>
</script>

<!-- 回复框 start -->
<div class="m-popup-reply" id="J_popupReply">
    <div class="topbar-operations">
        <a class="button-cancel J_buttonClosePopup" href="javascript:" dace-node="{%$id4dace%}_cancelComment">取消</a>
        <h2 class="title">发表评论</h2>
        <a href="javascript:" class="button-submit J_buttonSubmit">提交</a>
    </div>
    <div class="popup-reply-wrap">
        <div class="quote-content J_popupQuoteContent"></div>
        <textarea placeholder="说说你的看法..." class="reply-textarea J_replyTexttarea" maxlength="4000"></textarea>
        <span class="words-number">6-4000字</span>
    </div>
</div>
<!-- 回复框 end -->

