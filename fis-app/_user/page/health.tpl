{%extends file="common/page/layout.tpl"%}

{%block name="title"%}健康{%/block%}

{%block name="head_static"%}
    {%require name="user:static/health/health.scss"%}
{%/block%}

{%block name="content"%}
    <section class="item today">
        <h2>今天</h2>
        <ul>
            <li>
                <div class="left">步数</div>
                <div class="right">
                    <div class="value"><span {%if empty($today.time)%}style="line-height:1.7;"{%/if%}>{%$today.step_count%}</span>步</div>
                    <div class="time">{%$today.time%}</div>
                </div>
            </li>
            <li>
                <div class="left">步行+跑步距离</div>
                <div class="right">
                    <div class="value"><span {%if empty($today.time)%}style="line-height:1.7;"{%/if%}>{%$today.distance_walking_running%}</span>公里</div>
                    <div class="time">{%$today.time%}</div>
                </div>
            </li>
            <li>
                <div class="left">活动能量</div>
                <div class="right">
                    <div class="value"><span {%if empty($today.time)%}style="line-height:1.7;"{%/if%}>{%$today.active_energy_burned%}</span>卡路里</div>
                    <div class="time">{%$today.time%}</div>
                </div>
            </li>
        </ul>
    </section>

    <section class="item yesterday">
        <h2>昨天</h2>
        <ul>
            <li>
                <div class="left">步数</div>
                <div class="right">
                    <div class="value"><span>{%$yesterday.step_count%}</span>步</div>
                </div>
            </li>
            <li>
                <div class="left">步行+跑步距离</div>
                <div class="right">
                    <div class="value"><span>{%$yesterday.distance_walking_running%}</span>公里</div>
                </div>
            </li>
            <li>
                <div class="left">活动能量</div>
                <div class="right">
                    <div class="value"><span>{%$yesterday.active_energy_burned%}</span>卡路里</div>
                </div>
            </li>
        </ul>
    </section>
{%/block%}
