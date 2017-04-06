{%extends file="common/page/layout.tpl"%}


{%block name="title"%}{%$result.profile.player_name%}{%/block%}
{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}

    <script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
    {%require name="match:static/page/football_team_data.scss"%}

    {%script%}
        window.GM = {
            "client": "{%$client%}" || "x",
            "version":"{%$version%}"|| "7.0.6",
            "islogin": !!parseInt("{%$is_login%}", 10),
            "player_name": "{%$profile.player_name%}",
            "player_enname": "{%$profile.player_enname%}"
        };
        var nbaTeam = require("match:widget/nba_team/nba_team.js");
        nbaTeam.init();
    {%/script%}
{%/block%}

{%block name="content"%}
    <section class="football-team-data">
        <div class="data-list">
            <ul>
                <li>
                    <a href="{%if isset($rankData.ptsavg) && $rankData.ptsavg != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=ptsavg{%else%}javascript:void(0){%/if%}">
                        <div class="score">
                            {%if !empty($countData.ptsavg) || $countData.ptsavg == 0%}
                                {%$countData.ptsavg%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>得分</div>
                        {%if !empty($rankData.ptsavg) %}
                            <span>联盟第<b>{%$rankData.ptsavg%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.ortg) && $rankData.ortg != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=ortg{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.ortg) || $countData.ortg == 0%}
                                {%$countData.ortg|round:1%}
                            {%else%}
                            -
                            {%/if%}

                        </div>
                        <div>进攻效率</div>
                        {%if !empty($rankData.ortg)%}
                            <span>联盟第<b>{%$rankData.ortg%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.opptsavg) && $rankData.opptsavg != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=opptsavg{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.opptsavg) || $countData.opptsavg == 0%}
                                {%$countData.opptsavg%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>失分</div>
                        {%if !empty($rankData.opptsavg)%}
                            <span>联盟第<b>{%$rankData.opptsavg%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.drtg) && $rankData.drtg != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=drtg{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.drtg) || $countData.drtg == 0%}
                                {%$countData.drtg|round:1%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>防守效率</div>
                        {%if !empty($rankData.drtg)%}
                            <span>联盟第<b>{%$rankData.drtg%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.pace) && $rankData.pace != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=pace{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.pace) || $countData.pace == 0%}
                                {%$countData.pace%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>回合数</div>
                        {%if !empty($rankData.pace)%}
                            <span>联盟第<b>{%$rankData.pace%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.trbavg) && $rankData.trbavg != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=trbavg{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.trbavg) || $countData.trbavg == 0%}
                                {%$countData.trbavg%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>篮板</div>
                        {%if !empty($rankData.trbavg)%}
                            <span>联盟第<b>{%$rankData.trbavg%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.drbavg) && $rankData.drbavg != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=drbavg{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.drbavg) || $countData.drbavg == 0%}
                                {%$countData.drbavg%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>防守篮板</div>
                        {%if !empty($rankData.drbavg)%}
                            <span>联盟第<b>{%$rankData.drbavg%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.orbavg) && $rankData.orbavg != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=orbavg{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.orbavg) || $countData.orbavg == 0%}
                                {%$countData.orbavg%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>进攻篮板</div>
                        {%if !empty($rankData.orbavg)%}
                            <span>联盟第<b>{%$rankData.orbavg%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.astavg) && $rankData.astavg != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=astavg{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.astavg) || $countData.astavg == 0%}
                                {%$countData.astavg%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>助攻</div>
                        {%if !empty($rankData.astavg)%}
                            <span>联盟第<b>{%$rankData.astavg%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.toavg) && $rankData.toavg != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=toavg{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.toavg) || $countData.toavg == 0%}
                                {%$countData.toavg%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>失误</div>
                        {%if !empty($rankData.toavg)%}
                            <span>联盟第<b>{%$rankData.toavg%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.stavg) && $rankData.stavg != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=stavg{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.stavg) || $countData.stavg == 0%}
                                {%$countData.stavg%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>抢断</div>
                        {%if !empty($rankData.stavg)%}
                            <span>联盟第<b>{%$rankData.stavg%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.blkavg) && $rankData.blkavg != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=blkavg{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.blkavg) || $countData.blkavg == 0%}
                                {%$countData.blkavg%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>盖帽</div>
                        {%if !empty($rankData.blkavg)%}
                            <span>联盟第<b>{%$rankData.blkavg%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.fgp) && $rankData.fgp != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=fgp{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.fgp) || $countData.fgp == 0%}
                                {%($countData.fgp*100)|round:1%}%
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>投篮命中率</div>
                        {%if !empty($rankData.fgp)%}
                            <span>联盟第<b>{%$rankData.fgp%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.tpp) && $rankData.tpp != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=tpp{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.tpp) || $countData.tpp == 0%}
                                {%($countData.tpp*100)|round:1%}%
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>三分命中率</div>
                        {%if !empty($rankData.tpp)%}
                            <span>联盟第<b>{%$rankData.tpp%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.ftp) && $rankData.ftp != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=ftp{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.ftp) || $countData.ftp == 0%}
                                {%($countData.ftp*100)|round:1%}%
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>罚球命中率</div>
                        {%if !empty($rankData.ftp)%}
                            <span>联盟第<b>{%$rankData.ftp%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.fta) && $rankData.fta != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=fta{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.fta) || $countData.fta == 0%}
                                {%$countData.fta%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>罚球</div>
                        {%if !empty($rankData.fta)%}
                            <span>联盟第<b>{%$rankData.fta%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.pf) && $rankData.pf != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=pf{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.pf) || $countData.pf == 0%}
                                {%$countData.pf%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>犯规</div>
                        {%if !empty($rankData.pf)%}
                            <span>联盟第<b>{%$rankData.pf%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.tf) && $rankData.tf != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=tf{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.tf) || $countData.tf == 0%}
                                {%$countData.tf%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>总技术犯规</div>
                        {%if !empty($rankData.tf)%}
                            <span>联盟第<b>{%$rankData.tf%}</b><i></i></span>
                        {%/if%}
                    </a>
                </li>
                <li>
                    <a href="{%if isset($rankData.ff) && $rankData.ff != '-'%}/{%$projectId%}/{%$version%}/nba/getDataRank?rank_type=ff{%else%}javascript:void(0) {%/if%}">
                        <div class="score">
                            {%if !empty($countData.ff)  || $countData.ff == 0%}
                                {%$countData.ff%}
                            {%else%}
                            -
                            {%/if%}
                        </div>
                        <div>总恶意犯规</div>
                        {%if !empty($rankData.ff)%}
                        <span>联盟第<b>{%$rankData.ff%}</b><i></i></span>
                        <!--
                            <span>联盟第<b>{%$rankData.ff%}</b><img height=6 src="../static/page/img/arrow-right-day.png?19" alt="arrow"></span>
                        -->
                        {%/if%}
                    </a>
                </li>
            </ul>
        </div>
        {%if !empty($fivePlayer)%}
        <div class="five">
            <table>
                <tr>
                    <td>&nbsp;</td>
                    <td>五人组</td>
                    <td>出场</td>
                    <td>时间</td>
                    <td>+/-</td>
                    <td>得分</td>
                    <td>篮板</td>
                    <td>前板</td>
                    <td>后板</td>
                    <td>投篮</td>
                </tr>
                {%foreach $fivePlayer as $val%}
                <tr>
                    <td>{%$val@index+1%}</td>
                    <td>
                        {%$val.p1_alias%} +
                        {%$val.p2_alias%} +
                        {%$val.p3_alias%} +
                        {%$val.p4_alias%} +
                        {%$val.p5_alias%}
                    </td>
                    <td>{%$val.games%}</td>
                    <td>{%$val.avg_duration|string_format:"%0.1f"%}</td>
                    <td>{%if $val.avg_plus_minus >0%}+{%/if%}{%($val.avg_plus_minus/60)|string_format:"%0.1f"%}</td>
                    <td>{%$val.avg_points|string_format:"%0.1f"%}</td>
                    <td>{%($val.avg_oreb + $val.avg_dreb)|string_format:"%0.1f"%}</td>
                    <td>{%$val.avg_oreb|string_format:"%0.1f"%}</td>
                    <td>{%$val.avg_dreb|string_format:"%0.1f"%}</td>
                    <td>{%($val.avg_fgmade / $val.avg_shot)|string_format:"%0.3f"%}</td>
                </tr>
                {%/foreach%}
            </table>
        </div>
        {%/if%}
        <div class="analyze">
            <a href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE">
                <div class="link-title">
                    <p class="title">虎扑篮球百科：进攻效率、防守效率等数据说明</p>
                    <i></i>
                </div>
            </a>
        </div>
    </section>
{%/block%}
