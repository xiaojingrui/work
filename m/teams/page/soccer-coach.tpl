{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
        {%require name="teams:static/soccer-coach/soccer-coach.scss"%}
{%/block%}
{%block name="content"%}
    {%widget
        name="common:widget/new-top-nav/new-top-nav.tpl"
        hasBreadNav=false
    %}

    {%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}

    <section class="m-wrap playersGameData-wrap">
        <!-- 球队信息 -->


          <div class="coach-header">
          <div class="contain">
          	<div class="photo">
          		<img src="{%$coachInfo.image_86x120_url%}">
          	</div>
          	<div class="massage">
          		<p>{%if !empty($coachInfo.official_name)%}
                  {%$coachInfo.official_name%}
                    {%else%}
                       {%$coachInfo.official_name_en%}
                    {%/if%}
                  {%if !empty($coachInfo.country_cn)%}
                  <img src="//b3.hoopchina.com.cn/images/country/{%$coachInfo.country_cn%}.jpg">
                  {%else%}

                  {%/if%}
                </p>
          		<p>{%if !empty($coachInfo.official_name_en)&& empty($coachInfo.official_name)%}

                  {%else%}
                    {%$coachInfo.official_name_en%}
                  {%/if%}
              </p>
          		<p>教练&nbsp;&nbsp; {%$coachInfo.team_name%}</p>
          	</div>
          </div>

          </div>

          <div class="season-content ">
              <div class="table-scroll general-table">
                  <table class="table">
                   <tbody>
                          <tr class="tr">
                              <td class="td1">{%$coachInfo.age%}</td>
                              <td class="td1">
                                 {%if !empty($coachInfo.country_cn)%}
                                    {%$coachInfo.country_cn%}
                                  {%elseif !empty($coachInfo.country)%}
                                    {%$coachInfo.country%}
                                  {%else%}
                                  不详
                                  {%/if%}
                                 </td>
                              <td class="td1">{%$coachInfo.birth_date|date_format:'%Y/%m/%d'%}</td>
                          </tr>
                      </tbody>
                      <tfoot >
                          <tr>
                              <th class="td1">年龄</th>
                              <th class="td1">国籍</th>
                              <th class="td1">出生年月</th>
                          </tr>
                      </tfoot>

                  </table>
                  <hr  class="hr">
              </div>
               <div class="table-scroll general-table">
                  <table class="table">

                      <tbody>
                      <tr>
                              <td class="number-1 new">加入</th>
                              <td class="number-2 new-1" >{%$coachInfo.join_date|date_format:'%Y/%m/%d'%}</th>
                          </tr>
                          {%if !empty({%$coachPrefer.prefer%})%}
                          <tr>
                              <td class="number-1 new">偏好</td>
                              <td class="number-2 new-1" >
                                <p id="preference">{%$coachPrefer.prefer%}&nbsp;&nbsp;&gt;&gt;</p>
                              </td>
                          </tr>
                           {%/if%}
                          {%if !empty($coachInfo.description)%}
                          <tr>
                              <td class="number-1 new">简介</td>
                              <td class="number-2 new-1">
                              <p>
                                  {%$coachInfo.description%}
                              </p>
                              </td>
                          </tr>
                          {%/if%}
                      </tbody>
                  </table>
              </div>

              <div class="table-scroll jpadding">
                  <table class="table table-2">
                  	 <tr>
                                  <td class="number-1 new new-2"><img src="../static/soccer-coach/images/rec.jpg" >执教生涯</td>


                       </tr>
                  </table>
                  {%if $coachCareer|@count eq 0 %}
                         <div class="mod_no_result">暂无教练生涯</div>
                  {%else%}
                  <table class="table table-2 setfontsize">

                      <thead>
                          <tr>
                              <th class="th1">执教时间</th>
                              <th class="th2">球队</th>
                              <th class="th3">比赛数</th>
                              <th class="th4">胜率</th>

                          </tr>

                      </thead>
                      <tbody>
                              {%foreach $coachCareer as $val%}
                            <tr>
                                  <td class="td2">{%$val.appointed_date%}~{%$val.until_date%}
                                   </td>
                                  <td class="td2">
                                  <span>
                                      {%if !empty($val.team_name_zh)%}
                                     {%$val.team_name_zh%}
                                      {%else%}
                                        不详
                                     {%/if%}
                                      </span>
                                  </td>
                                  <td class="td2">
                                      {%if !empty($val.matches)%}
                                      {%$val.matches%}
                                       {%else%}
                                         --
                                      {%/if%}
                                  </td>
                                  <td class="td2">
                                      {%if !empty($val.winpercent)%}
                                      {%$val.winpercent%}%
                                      {%else%}
                                         --
                                      {%/if%}
                                 </td>

                              </tr>
                             {%/foreach%}
                      </tbody>
                  </table>
                   {%/if%}
              </div>
          </div>

           <div id="mask"></div>

            <div class="popup" id="pop">
            <div class="tit">
            <span>最近{%$coachPrefer.total%}场比赛使用首发阵型统计：</span>
            </div>
            <div class="tabscroll" id="totop">
                <table class="poptab table ">
                   <tbody class="tbodyinner">
                       {%foreach from=$coachPrefer.tactic  key=colkey  item=colvalue %}
                       <tr>

                           <td class="d1">
                              {%if !empty($colkey)%}
                              {%$colkey%}
                              {%else%}
                                 未知阵型
                              {%/if%}
                           </td>
                           <td class="d2">
                           {%if !empty($colvalue)%}
                              {%$colvalue%}
                              {%else%}
                                 --
                              {%/if%}
                              </td>

                       </tr>
                       {%/foreach%}


                   </tbody>

                </table>
            </div>
           <div id="cancel">
            <span>关闭</span>
            </div>
            </div>

    </section>
     {%require name="teams:static/soccer-coach/soccer-coach.js"%}
{%/block%}
