<header class="teams-header">
    <div class="teams-header-color">
        <div class="teams-main-info">
            <div class="teams-left">
                <div class="teams-logo">
                    <img src="{%$teamInfo.image_87x87_url%}" alt="{%$teamInfo.image_87x87_url%}"/>
                </div>
            </div>
            <div class="teams-right">
                <div class="teams-text">
                    {%$teamInfo.known_name%}<br />
                    <span class="font-14">{%$teamInfo.known_name_en%}</span>
                </div>
            </div>
        </div>
        <div class="teams-other">
            <div class="teams-left">
                <div class="title">
                    {%if !empty($teamInfo.founded)%}成立时间<br/>{%/if%}
                    {%if !empty($teamInfo.city)%}所在城市<br/>{%/if%}
                    现任教练
                </div>
            </div>
            <div class="teams-right">
                <div class="main-text">
                    {%if !empty($teamInfo.founded)%}{%$teamInfo.founded|default:"--"%}年<br />{%/if%}
                    {%if !empty($teamInfo.city)%}{%$teamInfo.city|default:"--"%}<br />{%/if%}
                    <a href="{%$coach_link%}" style="color: #fff;">
                    {%if !empty($officialInfo.official_name)%}
                    {%$officialInfo.official_name%}
                    {%else%}
                    {%$officialInfo.official_name_en|default:"--"%}
                    {%/if%}
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>
