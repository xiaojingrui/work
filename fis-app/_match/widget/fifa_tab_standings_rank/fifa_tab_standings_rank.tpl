<section class="mod-rank swiper-slide swiper-no-swiping">
    <div class="main">
        {%if !empty($data[$type])%}
            {%foreach $data[$code] as $val%}
            <table class="mod-title title">
                <thead>
                    <td width="10%" align="center"></td>
                    <td width="32%" colspan="2" align="left">球队</td>
                    <td width="10%" align="center">场次</td>
                    <td width="7%" align="center">胜</td>
                    <td width="7%" align="center">平</td>
                    <td width="7%" align="center">负</td>
                    <td width="17%" align="center">进/失</td>
                    <td width="10%" align="center">积分</td>
                </thead>
            </table>
            <table class="mod-table">
                <tbody>
                    {%foreach $val as $subVal%}
                    <tr class="tap">
                        <td width="10%" align="center">
                            <span class="num">{%$subVal.rank%}</span>
                        </td>
                        <td width="10%" align="left">
                            <span class="logo"><img class="lazy" width="28" data-original="{%$subVal.logo%}?{%$val@index%}{%$subVal@index%}" /></span>
                        </td>
                        <td width="22%" align="left">{%$subVal.name%}</td>
                        <td width="10%" align="center">{%$subVal.mp%}</td>
                        <td width="7%" align="center">{%$subVal.won%}</td>
                        <td width="7%" align="center">{%$subVal.draw%}</td>
                        <td width="7%" align="center">{%$subVal.lose%}</td>
                        <td width="17%" align="center">{%$subVal.gf%}/{%$subVal.ga%}</td>
                        <td width="10%" align="center">{%$subVal.pts%}</td>
                    </tr>
                    {%/foreach%}
                </tbody>
            </table>
            {%/foreach%}
        {%else%}
            <div class="no-data">暂无数据</div>
        {%/if%}
    </div>
</section>
