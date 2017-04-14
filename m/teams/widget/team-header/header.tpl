<header class="teams-header">
    <div class="teams-header-color" style="background:rgba({%$teamBgColor%},.6)">
        <div class="teams-main-info">
            <div class="teams-left">
                <div class="teams-logo">
                    <img src="{%$teamInfo.logo_link%}" alt=""/>
                </div>
            </div>
            <div class="teams-right">
                <div class="teams-text">
                    {%$teamInfo.full_name%}<br />
                    <span class="font-14">{%$teamInfo.eng_full_name%}</span>
                </div>
            </div>
        </div>
        <div class="teams-other">
            <div class="teams-left">
                <div class="title">
                    进入NBA<br/>
                    主球场<br/>
                    分区<br />
                    主教练<br />
                    本赛季成绩
                </div>
            </div>
            <div class="teams-right">
                <div class="main-text">
                    {%$teamInfo.found_year%}年<br />
                    {%$teamInfo.home%}<br />
                    {%$teamInfo.conferenceCn%}{%$teamInfo.cn_division%}<br />
                    {%$teamInfo.chief_coach%}<br />
                    {%$teamInfo.winCn%} {%$teamInfo.lostCn%} {%$teamInfo.rankCn%}
                </div>
            </div>
        </div>
    </div>
</header>
