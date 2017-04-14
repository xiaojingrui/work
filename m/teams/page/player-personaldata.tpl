{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="teams:static/player-personaldata/player-personaldata.scss"%}


{%/block%}
{%block  name="content"%}
    <!-- {%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %} -->
    <section class="m-wrap playersGameData-wrap">


        <div class="season-content ">
        <div class="playername"><a href={%$playerBasic.player_link%}>{%$playerBasic.name%}</a>
                          <span><a href={%$playerBasic.team_link%}>{%$playerBasic.team_name%}</a></span></div>
            <div class="main-title2">
               <img src="../static/soccer-coach/images/rec.jpg" >
               <span>职业生涯常规赛平均数据</span>
            </div>
            <div class="table-scroll general-table">
                 <!--  <div class="table-scroll0"> -->
                <table class="table1 table-scroll0">
                    <thead>
                        <tr>
                            <th class="number-1">赛季</th>
                        </tr>
                    </thead>
                    <tbody>
                     {%foreach $playerStats.REGULAR as $val%}
                        <tr>
                            <td class="number-1">{%$val.season%}</td>
                        </tr>
                    {%/foreach%}

                    </tbody>
                    <tfoot>
                          <td class="number-2" >生涯均值</td>
                    </tfoot>
                </table>
                <div class="table-scroll">
                    <table class="table1 table">
                        <thead>
                            <tr>
                                <th class="number-2">球队</th>
                                <th class="number-3">场次</th>
                                <th class="number-4">首发</th>
                                <th class="number-5">时间</th>
                                <th class="number-6">得分</th>
                                <th class="number-7">篮板</th>
                                <th class="number-8">助攻</th>
                                <th class="number-9">抢断</th>
                                <th class="number-10">盖帽</th>
                                <th class="number-11">失误</th>
                                <th class="number-12">投篮</th>
                                <th class="number-13">命中率</th>
                                <th class="number-14">三分</th>
                                <th class="number-15">三分命中率</th>
                                <th class="number-16">罚球</th>
                                <th class="number-17">罚球命中率</th>
                                <th class="number-18">犯规</th>


                            </tr>
                        </thead>
                        <tbody>
                         {%foreach $playerStats.REGULAR as $val%}
                            <tr>
                                <td class="number-2">{%$val.team_name%}</td>
                                    <td class="number-3">{%$val.games%}</td>
                                    <td class="number-4">{%$val.games_started%}</td>
                                    <td class="number-5">{%$val.mins%}</td>
                                    <td class="number-6">{%$val.pts%}</td>
                                    <td class="number-7">{%$val.reb%}</td>
                                    <td class="number-8">{%$val.asts%}</td>
                                    <td class="number-9">{%$val.stl%}</td>
                                    <td class="number-10">{%$val.blk%}</td>
                                    <td class="number-11">{%$val.to%}</td>
                                    <td class="number-12">{%$val.fga%}</td>
                                    <td class="number-13">{%$val.fgp%}%</td>
                                    <td class="number-14">{%$val.tpa%}</td>
                                    <td class="number-15">{%$val.tpp%}%</td>
                                    <td class="number-16">{%$val.fta%}</td>
                                    <td class="number-17">{%$val.ftp%}%</td>
                                    <td class="number-18">{%$val.foul%}</td>

                            </tr>
                            {%/foreach%}
                            </tbody>
                            <tfoot>
                            <tr>

                                <td class="number-3" ></td>

                                <td class="number-3">{%$playerStats.REGULAR_AVG.count|default :"--"%}</td>
                                <td class="number-4">{%$playerStats.REGULAR_AVG.games_started|default :"--"|mb_substr:0:4%}</td>
                                <td class="number-5">{%$playerStats.REGULAR_AVG.mins|default :"--"%}</td>
                                <td class="number-6">{%$playerStats.REGULAR_AVG.pts|default :"--"%}</td>
                                <td class="number-7">{%$playerStats.REGULAR_AVG.reb|default :"--"%}</td>
                                <td class="number-8">{%$playerStats.REGULAR_AVG.asts|default :"--"%}</td>
                                <td class="number-9">{%$playerStats.REGULAR_AVG.stl|default :"--"%}</td>
                                <td class="number-10">{%$playerStats.REGULAR_AVG.blk|default :"--"%}</td>
                                <td class="number-11">{%$playerStats.REGULAR_AVG.to|default :"--"%}</td>
                                <td class="number-12">{%$playerStats.REGULAR_AVG.fga|default :"--"%}</td>
                                <td class="number-13">{%$playerStats.REGULAR_AVG.fgp|default :"--"%}</td>
                                <td class="number-14">{%$playerStats.REGULAR_AVG.tpa|default :"--"%}</td>
                                <td class="number-15">{%$playerStats.REGULAR_AVG.tpp|default :"--"%}</td>
                                <td class="number-16">{%$playerStats.REGULAR_AVG.fta|default :"--"%}</td>
                                <td class="number-16">{%$playerStats.REGULAR_AVG.ftp|default :"--"%}</td>
                                <td class="number-16">{%$playerStats.REGULAR_AVG.foul|default :"--"%}</td>

                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
            <div >
                <div class="main-title2">
                  <img src="../static/soccer-coach/images/rec.jpg" >
                   <span> 职业生涯季后赛平均数据</span>
                </div>
                <div class="table-col-1">
                   <!--  <div class="table-scroll0"> -->
                        <table class="table1 table-scroll0">
                            <thead>
                                <tr>
                                    <th class="number-1">赛季</th>
                                </tr>
                            </thead>
                            <tbody>
                            {%foreach $playerStats.PLAYOFF as $val%}
                                <tr>
                                    <td class="number-1">{%$val.season%}</td>
                                </tr>
                            {%/foreach%}

                            </tbody>
                            <tfoot>
                                 <td class="number-2">生涯均值</td>
                            </tfoot>
                        </table>


                    <div class="table-scroll">
                        <table class="table1  table">
                            <thead>
                                <tr>
                                    <th class="number-2">球队</th>
                                    <th class="number-3">场次</th>
                                    <th class="number-4">首发</th>
                                    <th class="number-5">时间</th>
                                    <th class="number-6">得分</th>
                                    <th class="number-7">篮板</th>
                                    <th class="number-8">助攻</th>
                                    <th class="number-9">抢断</th>
                                    <th class="number-10">盖帽</th>
                                    <th class="number-11">失误</th>
                                    <th class="number-12">投篮</th>
                                    <th class="number-13">命中率</th>
                                    <th class="number-14">三分</th>
                                    <th class="number-15">三分命中率</th>
                                    <th class="number-16">罚球</th>
                                    <th class="number-17">罚球命中率</th>
                                    <th class="number-18">犯规</th>


                                </tr>
                            </thead>
                            <tbody>
                                    {%foreach $playerStats.PLAYOFF as $val%}
                                <tr>

                                    <td class="number-2">{%$val.team_name%}</td>
                                    <td class="number-3">{%$val.games%}</td>
                                    <td class="number-4">{%$val.games_started%}</td>
                                    <td class="number-5">{%$val.mins%}</td>
                                    <td class="number-6">{%$val.pts%}</td>
                                    <td class="number-7">{%$val.reb%}</td>
                                    <td class="number-8">{%$val.asts%}</td>
                                    <td class="number-9">{%$val.stl%}</td>
                                    <td class="number-10">{%$val.blk%}</td>
                                    <td class="number-11">{%$val.to%}</td>
                                    <td class="number-12">{%$val.fga%}</td>
                                    <td class="number-13">{%$val.fgp%}%</td>
                                    <td class="number-14">{%$val.tpa%}</td>
                                    <td class="number-15">{%$val.tpp%}%</td>
                                    <td class="number-16">{%$val.fta%}</td>
                                    <td class="number-17">{%$val.ftp%}%</td>
                                    <td class="number-18">{%$val.foul%}</td>

                                </tr>
                                {%/foreach%}
                                    </tbody>
                                    <tfoot>

                                     <tr>

                                    <td class="number-3"></td>
                                    <td class="number-3">{%$playerStats.PLAYOFF_AVG.count|default :"--"%}</td>
                                     <td class="number-4">{%$playerStats.PLAYOFF_AVG.games_started|default :"--"|mb_substr:0:4%}</td>
                                    <td class="number-5">{%$playerStats.PLAYOFF_AVG.mins|default :"--"%} </td>
                                    <td class="number-6">{%$playerStats.PLAYOFF_AVG.pts|default :"--"%} </td>
                                     <td class="number-7">{%$playerStats.PLAYOFF_AVG.reb|default :"--"%}</td>
                                    <td class="number-8">{%$playerStats.PLAYOFF_AVG.asts|default :"--"%}</td>
                                    <td class="number-9">{%$playerStats.PLAYOFF_AVG.stl|default :"--"%}</td>
                                    <td class="number-10">{%$playerStats.PLAYOFF_AVG.blk|default :"--"%}</td>
                                    <td class="number-11">{%$playerStats.PLAYOFF_AVG.to|default :"--"%}</td>
                                    <td class="number-12">{%$playerStats.PLAYOFF_AVG.fga|default :"--"%}</td>
                                    <td class="number-13">{%$playerStats.PLAYOFF_AVG.fgp|default :"--"%}</td>
                                    <td class="number-14">{%$playerStats.PLAYOFF_AVG.tpa|default :"--"%}</td>
                                    <td class="number-15">{%$playerStats.PLAYOFF_AVG.tpp|default :"--"%}</td>
                                    <td class="number-16">{%$playerStats.PLAYOFF_AVG.fta|default :"--"%}</td>
                                    <td class="number-17">{%$playerStats.PLAYOFF_AVG.ftp|default :"--"%}</td>
                                    <td class="number-18">{%$playerStats.PLAYOFF_AVG.foul|default :"--"%}</td>

                                    </tr>
                                    </tfoot>


                        </table>
                    </div>
                </div>
            </div>

        </div>
    </section>

{%/block%}.
