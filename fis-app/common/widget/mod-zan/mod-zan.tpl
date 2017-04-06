<div class="mod-zan" id="J-zan-container">
  {%if $type != "bbs" || count($users) >= 1%}
  <div class="zan-author">
    <a href="kanqiu://people/{%$author.uid%}" dace-node="reward_writer">
        <img src="{%$author.header|default:'//b1.hoopchina.com.cn/games/images/man.jpg'%}" class="user-icon J-user-avatar-img" /> {%$author.nickname|default:'神秘球迷'%}
        <span class="mod-mask mask"></span>
    </a>
    <span class="zan-tag">{%$callname%}</span>
  </div>
  {%/if%}
  <span class="zan-btn J-zan" dace-node="reward_pay">赞赏{%$callname%}</span>
  {%if !empty($users)%}
  <br />
  <div class="zan-list J-zanlist" dace-node="reward_people">
    {%foreach $users as $index => $user%}
       {%if $index < 3%}
         <span class="zan-userimg">
          <img src="{%$user.header|default:'//b1.hoopchina.com.cn/games/images/man.jpg'%}?{%$index%}" alt="{%$user.nickname%}" class="user-icon J-user-avatar-img" />
          <span class="mod-mask mask"></span>
         </span>
       {%/if%}
    {%/foreach%}
    <span class="J-zan-detail">已有<span class="zan-count">{%$userCount%}</span>个JRs赞赏了{%$goldCount%}虎扑币 &gt;</span>
  </div>
  {%/if%}
</div>
{%script%}
require("./mod-zan.js").init(
{
  type: "{%$type%}",
  tips: "{%$tips%}",
  nickname: "{%$author.nickname%}",
  typeid: "{%$typeid%}",
  fid: "{%$fid%}",
  userCount: Math.max({%count($users)%}, parseInt("{%$userCount%}", 10) || 0),
  goldCount: parseInt("{%$goldCount%}", 10) || 0,
}, {%intval((count($users) >= 1))%});
{%/script%}
