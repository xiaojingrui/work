{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%require name="my:static/message/message.scss"%}
    {%require name="my:static/home/home.js"%}
{%/block%}

{%block name="content"%}

{%widget
    name="common:widget/top-title/top-title.tpl"
    banner="我的消息"
%}

    <div class="message-wrap">
        <div class="message-list">
            {%if $notifications.notificationsinfo|@count > 0%}
                <ul class="list" id="J_notificationList">
                    {%foreach from=$notifications.notificationsinfo item=val name=key%}
                        <li class="{%if empty($val.read)%}no-view{%/if%} J_messageLi" data-mid="{%$val.id%}">
                            <h4 class="sub-title">
                                {%$val.title|escape:none%}
                            </h4>
                            <a href="javascript:;" class="button-close J_buttonMessageClose"></a>
                        </li>
                    {%/foreach%}
                </ul>
            {%else%}
                <div class="not-message">
                    暂无更多消息
                </div>
            {%/if%}
        </div>
        {%widget
            name="common:widget/ui/page/page.tpl"
            pageCount=$notifications.pageCount
            page=$notifications.page
            urlBase="/my/notifications/?page=#{page}"
        %}
    </div>
{%/block%}
