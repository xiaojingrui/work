<div class="m-reply" id="J-all-reply">
    <div class="bright-reply" id="J-light-container"></div>

    {%if !empty($bottom_ad)%}
      <div id="J_bottom_support" class="card-container" style="display:none">
          <div class="card-tips"><em>由赞助商提供</em></div>
          <div class="card-spread">
              <a href="{%$bottom_ad.url%}" dace-node="bbs_detailsAd">
                  <div class="pic">
                      <img src="{%$bottom_ad.img%}" alt=""/>
                      <span class="mod-mask mask"></span>
                  </div>
                  <div class="card-title">
                      <span class="tags">广告</span>{%$bottom_ad.title%}
                      <i class="arrow-right"></i>
                  </div>
              </a>
          </div>
      </div>
    {%/if%}

    <div class="general-reply-container" id="J-scroll-wrapper">
        <div class="general-reply" id="J-reply-container"></div>
    </div>

    <div class="general-reply-more" id="J-touch-addmorepost">
        轻击瞅瞅新回复来了没
    </div>

    <script type="text/template" id="J-reply-tpl">
        <@if(title){@>
        <div class="title-out">
            <div class="title">
                <h2><@=title@></h2>
            </div>
        </div>
        <@}@>
        <div class="reply-inner">
            <@if(list && list.length){@>
            <@_.each(list, function(item){@>
                <dl class="reply-list" data-pid="<@=item.pid@>" data-uid="<@=item.puid@>" data-username="<@=item.userName@>" data-floor="<@=item.floor@>">
                    <dd class="operations-user">
                        <a href="kanqiu://people/<@=item.puid@>" class="user-avatar" dace-node="postuser">
                            <img src="<@=item.userImg@>" class="J-user-avatar-img" alt="<@=item.userName@>" >
                            <span class="mod-mask mask"></span>
                        </a>
                        <div class="user-info">
                            <@if (item.puid == author_puid){@>
                                <div class="user-name clearfix">
                                    <div class="fl"><a class="J_name_word" href="kanqiu://people/<@=item.puid@>"><@=item.userName@></a>

                                        <i>楼主</i>
                                        <@if (item.certurl){@>
                                        <a href="kanqiu://people/<@=item.puid@>" class="certification">
                                            <img src="<@=item.cert.image@>" alt="" height="22">
                                        </a>
                                        <@}@>
                                    </div>

                                </div>
                            <@}else{@>
                                <div class="user-name clearfix">
                                    <div class="fl">
                                        <a dace-node="post_user" class="no_louzhu" href="kanqiu://people/<@=item.puid@>">
                                            <@=item.userName@>
                                        </a>
                                        <@if (item.certurl){@>
                                        <a href="kanqiu://people/<@=item.puid@>" class="certification">
                                            <img src="<@=item.cert.image@>" alt="" height="22">
                                        </a>
                                        <@}@>
                                    </div>
                                </div>
                            <@}@>
                            <div class="source-left">
                                <@if(item.floor){@>
                                    <span class="floor"><@=item.floor@>楼</span>
                                <@}@>
                                <@if(item.time){@>
                                    <span class="postdate"><@=item.time@></span>
                                <@}@>
                            </div>
                        </div>
                        <span class="reply-light">亮了(<@=item.light_count||0@>)</span>
                    </dd>
                    <dt class="reply-content" style="font-size:<@=GM.ft-2@>px;">
                        <@if ((item.quote) && $.isArray(item.quote) && item.quote.length > 0){@>
                            <div class="reply-quote-content">
                                <@if(item.quote_deleted){@>
                                    <div class="reply-quote-delete">
                                        <@=item.quote[0].content@>
                                    </div>
                                <@}else{@>
                                    <div class="reply-quote-hd">
                                        <@=item.quote[0].header[0]@>
                                    </div>
                                    <@if(item.quote[0].togglecontent){@>
                                        <div class="short-quote-content J_shortContent">
                                            <@=item.quote[0].togglecontent@>
                                        </div>
                                        <div class="reply-quote-bd J_allContent">
                                            <@=item.quote[0].content@>
                                        </div>
                                        <div class="button-open-inner">
                                            <a class="button-open J_buttonOpenAll" title="展开">显示全部 <s class="arrow"></s></a>
                                        </div>
                                    <@}else{@>
                                        <div class="short-quote-content">
                                            <@=fliter(item.quote[0].content)@>
                                        </div>
                                    <@}@>
                                <@}@>
                            </div>
                        <@}@>
                        <div class="current-content J_contentParent">
                            <span class="short-content">
                                <@=fliter(item.content)@>
                            </span>
                        </div>
                        <@if(item.praise){@>
                        <div class="praise-reply J-praise-<@=item.pid@>" dace-node='replyreward_people'>
                            已有<span class="praise-person"><@=item.praise.list.userCount@></span>个JRs赞赏了<span class="praise-count"><@=item.praise.list.goldCount@></span>虎扑币 &gt;
                        </div>
                        <@}@>
                    </dt>
                </dl>
           <@})@>
           <@}else{@>
            <div class="reply-empty">暂无回复</div>
           <@}@>
        </div>
    </script>
</div>
