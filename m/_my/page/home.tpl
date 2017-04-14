{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%require name="my:static/home/home.scss"%}
    {%require name="my:static/home/home.js"%}
{%/block%}

{%block name="content"%}

{%widget
    name="common:widget/top-title/top-title.tpl"
    banner="{%if $isself %}我{%else%}{%$userinfos.username%}{%/if%}的主页"
%}

<div class="personal-info">
    <a href="{%$detailUrl%}" dace-node="{%$id4dace%}_7001">
        <div class="personal-list">
            <div class="avatar" style="background-image: url({%$userinfos.header%});"></div>
            <div class="user-col">
                <div class="name">
                    {%$userinfos.username%}
                </div>
                <div class="level">论坛等级&nbsp;{%$userinfos.level%}级</div>
                <div class="calories">卡路里&nbsp;{%$userinfos.bank.money%}</div>
            </div>
        </div>
    </a>
</div>

{%if $isself %}
    {%if $collectedForums|@count > 0 %}
        <div class="m-card my-board m-card-split-line">
            <div class="card-head">
                <span class="card-title">我的版块</span>
            </div>
            <div id="J_boardItem" class="board-item">
                <div class="board-list-wrap">
                    {%foreach from=$collectedForums item=val name=key%}
                        {%if !empty($val['name'])%}
                            <a href="{%$val['forumindex']%}" dace-node="{%$id4dace%}_5052"><span>{%$val['name']|escape:none%}</span></a>
                        {%/if%}
                    {%/foreach%}
                </div>
                <a href="javascript:;" class="button-unfold J_buttonUnfold"></a>
            </div>
        </div>
    {%/if%}
    <div class="m-card my-notif m-card-split-line">
        <div class="card-head">
            <span class="card-title" dace-node="{%$id4dace%}_msm_close">
                我的消息
                {%if $message_unread != 0%}
                    <i class="message-unread-num">
                        {%if $message_unread > 99%}
                            99+
                        {%else%}
                            {%$message_unread%}
                        {%/if%}
                    </i>
                {%/if%}
            </span>
            {%if $notifications|@count > 0%}
                <span class="ignore-all" id="J_buttonIgnoreAll">全部忽略</span>
            {%/if%}
        </div>
        <div>
            {%if $notifications|@count > 0%}
                <ul id="J_notificationList">
                    {%foreach from=$notifications item=val name=key%}
                        <li class="no-view J_messageLi" data-mid="{%$val.id%}">
                            {%if $val.type == 1%}
                                [帖子]&nbsp;你的帖子&nbsp;<a href="javascript:;" data-href="{%$val.thread_url%}">{%$val.title|escape:none%}</a>&nbsp;新增{%$val.num%}回复
                            {%else if $val.type == 32%}
                                [帖子]&nbsp;你的帖子&nbsp;<a href="javascript:;" data-href="{%$val.thread_url%}">{%$val.title|escape:none%}</a>&nbsp;被推荐{%$val.rec_num%}次
                            {%else if $val.type == 40%}
                                [帖子]&nbsp;{%$val.opt_user_name%}&nbsp;在帖子&nbsp;<a href="javascript:;" data-href="{%$val.thread_url%}">{%$val.title|escape:none%}</a>&nbsp;中提到了你
                            {%else if $val.type == 48%}
                                [帖子]&nbsp;你在&nbsp;<a href="javascript:;" data-href="{%$val.thread_url%}">{%$val.title|escape:none%}</a>&nbsp;中的回复被亮了{%$val.light_num%}次
                            {%/if%}
                            <i class="close J_buttonMessageClose"></i>
                        </li>
                    {%/foreach%}
                </ul>
            {%else%}
                <div id="J_messageEmptyTip" style="display: block;" class="not-ignore">暂时没有未处理的消息</div>
            {%/if%}

            <a href="{%$messageUrl%}" id="J_buttonIgnoreAll" class="button-view-all" dace-node="{%$id4dace%}_7002">{%if $notifications|@count > 0%}查看全部消息{%else%}查看历史消息{%/if%}</a>
        </div>
    </div>

    <ul class="fn-list">
        <li class="m-card-split-line">
            <a href="{%$predictdata.url%}" dace-node="{%$id4dace%}_" class="predict-link">
                <span class="text-inner">我的预测</span>
                <div class="predict-result">共参与{%$predictdata.times%}场，命中{%$predictdata.correct%}场</div>
            </a>
        </li>
        <li>
            <a href="{%$collectedthreadsUrl%}" dace-node="{%$id4dace%}_7003">
                <span class="text-inner">我的收藏</span>
            </a>
        </li>
        <li>
            <a href="{%$threadsUrl%}" dace-node="{%$id4dace%}_7004">
                <span class="text-inner">我的主题帖</span>
            </a>
        </li>
        <li class="m-card-split-line">
            <a href="{%$repliesUrl%}" dace-node="{%$id4dace%}_7005">
                <span class="text-inner">我的回帖</span>
            </a>
        </li>
        <li>
            <a href="https://passport.hupu.com/ucenter/mindex" dace-node="{%$id4dace%}_8800">
                <span class="text-inner">帐号安全</span>
            </a>
        </li>
        <li>
            <a href="/my/usersetting" dace-node="{%$id4dace%}_7010">
                <span class="text-inner">设置</span>
            </a>
        </li>
    </ul>
{%else%}
    <div class="m-card latest-activity m-card-split-line">
        <div class="card-head">
            <span class="card-title">最近动态</span>
        </div>
        {%widget
            name = "my:widget/personal-news-list/list.tpl"
            data = $userdynamic
        %}
        {%if empty($userdynamic.error)%}
            {%if $userdynamic.data|@count >= 10%}
                {%if !empty($username) %}
                    <a href="{%$dynamicUrl%}" class="button-view-all" dace-node="{%$id4dace%}_7101">查看更多动态</a>
                {%else%}
                    <a href="{%$loginurl%}" class="button-login">登录后可查看 TA 的更多动态</a>
                {%/if%}
            {%/if%}
        {%/if%}
    </div>
    <ul class="fn-list">
        <li class="m-card-split-line">
            <a href="{%$predictdata.url%}" dace-node="{%$id4dace%}_" class="predict-link">
                <span class="text-inner">Ta的预测</span>
                <div class="predict-result">共参与{%$predictdata.times%}场，命中{%$predictdata.correct%}场</div>
            </a>
        </li>
    </ul>
{%/if%}

{%/block%}
