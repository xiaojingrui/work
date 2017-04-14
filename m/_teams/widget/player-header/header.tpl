<header class="players-header">
    <div class="players-header-color" style="background:rgba({%$teamBgColor%},.6)">
        <div class="players-basic">
            <dl>
                <dd class="avatar">
                    <img src="{%$playerBasic.photo_link%}" alt=""/>
                </dd>
                <dt class="name">{%$playerBasic.name%}</dt>
                <dd class="en-name">{%$playerBasic.eng_name%}</dd>
                <dd class="other-info">
                    <span>{%$playerBasic.number%}号</span>
                    <span>{%$playerBasic.position%}</span>
                    <span>{%$playerBasic.teamName%}</span>
                </dd>
            </dl>
        </div>
        <div class="other-data-table">
            <table class="table">
                <tr>
                    <td class="number-1">身高</td>
                    <td class="number-2">{%$playerBasic.height_fix%}米 / {%$playerBasic.height_fix2%}</td>
                </tr>
                <tr>
                    <td class="number-1">体重</td>
                    <td class="number-2">{%$playerBasic.weight_fix%}公斤 / {%$playerBasic.weight%}磅</td>
                </tr>
                <tr>
                    <td class="number-1">生日</td>
                    <td class="number-2">{%$playerBasic.birth_date_fix2%}</td>
                </tr>
                <tr>
                    <td class="number-1">选秀</td>
                    <td class="number-2">
                        {%if isset($playerBasic.draft_year) && !empty($playerBasic.draft_year)%}
                            {%$playerBasic.draft_year%}年第{%$playerBasic.draft_round%}轮第{%$playerBasic.draft_pick%}顺位
                        {%else%}
                            --
                        {%/if%}
                    </td>
                </tr>
                <tr>
                    <td class="number-1">出生地</td>
                    <td class="number-2">{%$playerBasic.country%}</td>
                </tr>
                <tr>
                    <td class="number-1">本赛季薪金</td>
                    <td class="number-2">
                        {%if isset($playerBasic.salary) && !empty($playerBasic.salary)%}
                            {%$playerBasic.salary%}万美元
                        {%else%}
                            --
                        {%/if%}
                    </td>
                </tr>
                <tr>
                    <td class="number-1">合同</td>
                    <td class="number-2">
                        {%if isset($playerBasic.wage) && !empty($playerBasic.wage)%}
                            {%$playerBasic.wage%}
                        {%else%}
                            --
                        {%/if%}
                    </td>
                </tr>
            </table>
        </div>
    </div>
</header>