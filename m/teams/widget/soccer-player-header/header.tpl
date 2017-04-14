{%$positions = [
     0 => "未知",
     1 => "守门员",
     2 => "后卫",
     3 => "中场",
     4 => "前锋",
     5 => "替补",
     6 => "中锋",
     7 => "边后卫",
     8 => "中后卫",
     9 => "后腰",
     10 => "前腰",
     11 => "中前卫",
     12 => "影子前锋",
     13 => "边锋",
     14 => "翼卫"
]%}
<header class="players-header">
    <div class="players-header-color">
        <div class="players-basic">
                <div class="avatar">
                    <img src="{%$playerInfo.image_86x120_url%}" alt=""/>
                </div>
                <div class="player-info">
                    <h3 class="name">{%$playerInfo.name%}</h3>
                    <h4 class="en-name">{%$playerInfo.name_en%}</h4>
                    <p class="other-info">
                        <span>{%$playerInfo.jersey_num%}号</span>
                        <span>{%$positions[$playerInfo.position]%}</span>
                        <span>{%$playerInfo.team_name%}</span>
                    </p>
                </div>
        </div>
    </div>
</header>