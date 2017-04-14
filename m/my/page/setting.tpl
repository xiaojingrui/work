{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%require name="my:static/setting/setting.scss"%}
    {%require name="my:static/setting/setting.js"%}
{%/block%}

{%block name="content"%}

{%widget
    name="common:widget/top-title/top-title.tpl"
    banner="设置"
%}

    <div class="setting-wrap">
        <div class="set-allow">
            <dl class="setting-list" id="J_settingWrap">
                <dt>
                    <div class="text">
                        允许他人查看我的动态
                    </div>
                    <div class="button-inner">
                        <a href="javascript:" dace-node="{%$id4dace%}_open" class="J_buttonSetting {%if $usersetting.thread != 0%}active{%/if%}" data-type="1">开</a>
                        <a href="javascript:" dace-node="{%$id4dace%}_close" class="J_buttonSetting {%if $usersetting.thread == 0%}active{%/if%}" data-type="0">关</a>
                    </div>
                </dt>
                {%**
                <dd class="select-area J_contentSelect" {%if $usersetting.thread == 0%}style="display: none;"{%/if%}>
                    <label class="lable">
                        所有人
                        <input type="radio" name="allow" value="1" {%if $usersetting.thread != 2%}checked="checked"{%/if%}/>
                    </label>
                </dd>
                <dd class="select-area J_contentSelect" {%if $usersetting.thread == 0%}style="display: none;"{%/if%}>
                    <label class="lable">
                        仅好友可见
                        <input type="radio" name="allow" value="2" {%if $usersetting.thread == 2%}checked="checked"{%/if%}/>
                    </label>
                </dd>
                **%}
            </dl>
        </div>

    </div>
{%/block%}