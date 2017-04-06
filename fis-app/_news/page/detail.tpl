{%extends file="common/page/layout.tpl"%}

{%block name="title"%}{%$news["title"]%}{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="news:static/detail/detail.scss"%}
    <script type="text/javascript" src="//w10.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
    {%script%}
      window.GM = {
          "nid": "{%$news.nid%}",
          "islogin": !!parseInt("{%$is_login%}", 10),
          "client": "{%$client%}" || "x",
          "projectId":"{%$projectId%}"||"null",
          "token": "{%$token%}",
          "version":"{%$version%}"||"7.0.6.0",
          "night":!!parseInt("{%$night%}", 10),
          "nopic":!!parseInt("{%$nopic%}", 10),
          "cid": "{%$cid%}" || "",
          "uid": "{%$uid%}" || "",
          "user_name": "{%$user_name%}" || "",
          "puid": "{%$puid%}" || "",
          "header": "{%$header%}" || "//b3.hoopchina.com.cn/games/images/man.jpg",
          "leaguesEn": "{%$leaguesEn%}" || "epl",
          "is_admin": !!parseInt("{%$is_admin%}", 10),
          "is_app": navigator.userAgent.indexOf("kanqiu"),
          "surprise": {%json_encode($surprise)%},
          "replies": parseInt("{%$news.replies%}", 10),
          "ft": "{%if intval($ft) < 12%}18{%else%}{%$ft%}{%/if%}"
      };
      var app = require("common:widget/ui-app/ui-app.js");
      app.init(function(){
          var detail = require("news:widget/detail/detail.js");
          detail.init();
      }, ~location.search.indexOf("debug"));
    {%/script%}
{%/block%}

{%block name="content"%}
<section class="detail-wrap">
    <div class="artical-main-content" id="J_mainContent">
      {%widget
          name="news:widget/artical-title/title.tpl"
          tplType="php"
          fromshare=false
      %}
      <article class="artical-content" style="font-size:{%if intval($ft) < 12%}18{%else%}{%$ft%}{%/if%}px;">
          {%if !empty($news.img_m)%}
              <div class="artical-main-pic">
              {%if $nopic%}
                  {%$defaultPic="//b3.hoopchina.com.cn/games/images/news_nopic_day@2x.png"%}
                  {%if $night%}
                    {%$defaultPic="//w10.hoopchina.com.cn/games/images/bbs-night-nopic.png"%}
                  {%/if%}
                  <img src="{%$defaultPic%}" data-src="{%$news.img_m%}" />
              {%else%}
                  <img src="{%$news.img_m%}" />
              {%/if%}
              </div>
          {%/if%}
          {%$news.content|escape:none%}
      </article>
      {%if !empty($news.tags)%}
          <section class="news-tags">
              <span class="tag-title">
                  标签:
              </span>
              <div class="tags-list">
                  {%foreach $news.tags as $item%}
                      <a href="{%$item.url%}" class="button-link" dace-node="news_tags">{%$item.name%}</a>
                  {%/foreach%}
              </div>
          </section>
      {%/if%}

      <!--赞赏-->
      {%if !empty($news.is_reward)%}
        {%$userInfo = [
            "header" => $news.author_header,
            "nickname" => $news.author_nickname,
            "uid" => $news.author_puid
          ]%}
        {%widget
          name="common:widget/mod-zan/mod-zan.tpl"
          author=$userInfo
          users=$news.reward_rank.data
          type="news"
          userCount=$news.reward_rank.total_people
          goldCount=$news.reward_rank.total_dollor
          callname=$news.author_type
          typeid=$news.nid
          tips=$news.tips
        %}
      {%/if%}
    </div>

    {%widget
        name="news:widget/reply/reply.tpl"
        replyType="detail"
    %}

    <div id="J_cardSpread">
    {%if !empty($news.recommend_data) && count($news.recommend_data)%}
      {%$recommend_data = $news.recommend_data[0]%}
      <div class="card-spread">
          <a href="{%$recommend_data.recommend_url%}" dace-node="news_detailsAd">
              <div class="pic">
                  <img src="{%$recommend_data.img%}" alt=""/>
                  <span class="mod-mask mask"></span>
              </div>
              <div class="title">
                  <span class="tags">广告</span>{%$recommend_data.title%}
                  <i class="arrow-right"></i>
              </div>
          </a>
      </div>
    {%/if%}
    </div>
</section>

{%/block%}
