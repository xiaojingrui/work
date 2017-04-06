<template>
<div class="mod-zan" v-el:container>
  <div class="zan-author" v-if="type != 'bbs' || users.length >= 1">
    <a href="kanqiu://people/{{author.uid}}" dace-node="reward_writer">
        <img :src="getUserHeader(author)" class="user-icon J-user-avatar-img" />{{userNickname}}
        <span class="mod-mask mask"></span>
    </a>
    <span class="zan-tag">{{callname}}</span>
  </div>
  <span class="zan-btn J-zan" @click="$emit('zan')" dace-node="reward_pay">赞赏{{callname}}</span>
  <div v-if="users.length">
      <div class="zan-list J-zanlist" @click="$emit('zanlist')" dace-node="reward_people">
         <span class="zan-userimg" v-for="user in showUsers">
          <img :src="getUserHeader(user)" class="user-icon J-user-avatar-img" />
          <span class="mod-mask mask"></span>
         </span>
        <span class="J-zan-detail">已有<span class="zan-count">{{userCount}}</span>个JRs赞赏了{{goldCount}}虎扑币 &gt;</span>
      </div>
  </div>
  <div class="zan-tips" v-if="showTips">
    <div class="zan-close" @click="$emit('tipclose')" dace-node="reward_tips"></div>
    {{tips}}
  </div>
</div>
</template>

<script>
import _ from 'underscore'
import $ from 'common/zepto'
import * as bridge from 'common/bridge'
import { getInfo } from 'common/app'
import * as Images from 'common/image'
import Store from 'common/store'

let zanToggle = new Store("hupu_praise_toggle_tips");
let toggleStore = {
  saveClosed: function(){
    zanToggle.setValue(1);
  },
  isTipsClosed: function(){
    return !!parseInt(zanToggle.getValue());
  }
}

export default {
    props:{
        type: String,
        users: {
            type: Array,
            default(){
                return []
            }
        },
        author: Object,
        callname: String,
        userCount: {
            type: Number,
            default: 0
        },
        goldCount: {
            type: Number,
            default: 0
        },
        typeid: String,
        fid: {
            type: String,
            default: ''
        },
        showTips: {
            type: Boolean,
            default: false
        },
        tips: String
    },
    ready(){
       this.nickname = this.author.nickname
       let isShowTips = this.users.length >= 1
       this.showTips = isShowTips && !toggleStore.isTipsClosed()
       this.bindEvent();
    },
    methods:{
        getUserHeader(user){
            return user.header || 'http://b10.hoopchina.com.cn/games/images/man.jpg'
        },
        bindEvent(){
            let $container = $(this.$els.container)
            Images.placeholderImages($container.find("img"));

            //赞赏拼参数
            this.bridgeParam = {
                type: this.type,
                typeid : this.typeid,
                nickname: this.nickname
            }
            if(this.fid){
                this.bridgeParam.fid = this.fid
            }
            //赞赏回调
            bridge.register("hupu.ui.admiresuccess", (res) => {
              //低版本或者新闻论坛正文赞赏
              if(res.type == 'bbs' || res.type == 'news'){
                  try{
                      this.appendUser({
                        nickname: res.nickname,
                        amount: parseInt(res.amount, 10),
                        userImg: res.userImg || 'http://b10.hoopchina.com.cn/games/images/man.jpg'
                      });
                  }catch(e){}
              } else{
                  $(document).trigger('bbs:replyzan', [res]);
              }
            });
        },
        appendUser( user ){
            this.users.unshift(user)
            this.userCount += 1;
            this.goldCount += user.amount;
        }
    },
    events:{
        'tipclose'(){
            toggleStore.saveClosed()
            this.showTips = false
        },
        'zan'(){
            bridge.send("hupu.ui.admire", this.bridgeParam);
        },
        'zanlist'(){
            bridge.send("hupu.ui.admirelist", this.bridgeParam);
        }
    },
    computed:{
        userNickname(){
            return this.author.nickname || '神秘球迷'
        },
        showUsers(){
            let showUsers = []
            this.users.forEach((user, idx) => {
                if(idx < 3){
                    showUsers.push(user)
                }
            })
            return showUsers
        }
    }
}
</script>

<style lang="less">
.detail-content .mod-zan {
    border-top: 0;
}

.mod-zan {
    border-top: 1px solid #eeebeb;
    text-align: center;
    .zan-author {
        font-size: 16px;
        line-height: 24px;
        height: 24px;
        margin: 8px 0;
    }

    .zan-author .user-icon {
        margin-right: 6px;
    }

    .zan-author a {
        color: #434141;
        vertical-align: bottom;
        margin-right: 4px;
        position: relative;
    }

    .zan-author .mask {
        width: 26px;
        height: 26px;
        border-radius: 50%;
        position: absolute;
        z-index: 5;
        left: -1px;
        top: -3px;
    }

    .zan-author .zan-tag {
        color: #c01e2f;
        border: 1px solid #c01e2f;
        border-radius: 2px;
        font-size: 12px;
        line-height: 24px;
        padding: 0 3px;
    }

    .zan-btn {
        background-color: #c01e2f;
        background-image: url(http://w10.hoopchina.com.cn/hybrid/static/common/widget/mod-zan/img/icon_56cc6b3.png);
        background-position: 9px center;
        background-repeat: no-repeat;
        background-size: 18%;
        border-radius: 6px;
        display: inline-block;
        line-height: 24px;
        height: 24px;
        padding: 3px 10px 3px 30px;
        margin: 0 auto 10px;
        font-size: 14px;
        color: #fff;
    }

    .zan-list {
        display: inline-block;
        background-color: #eeebeb;
        color: #a9a9b2;
        margin: 0 auto 10px;
        border-radius: 18px;
        line-height: 26px;
        height: 26px;
        padding: 3px 20px;
        font-size: 12px;
    }

    .zan-list .zan-count {
        color: #c01e2f;
        font-weight: 700;
    }

    .zan-list .zan-userimg {
        position: relative
    }

    .zan-list .mask {
        width: 26px;
        height: 26px;
        border-radius: 50%;
        position: absolute;
        z-index: 5;
        left: 0;
        top: -5px;
    }

    .zan-tips {
        background-color: #d97882;
        color: #fff;
        font-size: 13px;
        font-weight: 700;
        text-align: left;
        padding: 5px 34px 5px 10px;
        margin-bottom: 15px;
        position: relative;
    }

    .zan-tips .zan-close {
        position: absolute;
        right: 3px;
        top: 50%;
        margin-top: -13px;
        width: 25px;
        height: 25px;
    }

    .zan-tips .zan-close:before,
    .zan-tips .zan-close:after {
        content: '';
        position: absolute;
        height: 1px;
        width: 18px;
        top: 50%;
        left: 2px;
        background: #fff;
    }

    .zan-tips .zan-close::before {
        -webkit-transform: rotate(45deg);
        -moz-transform: rotate(45deg);
        -ms-transform: rotate(45deg);
        -o-transform: rotate(45deg);
        transform: rotate(45deg);
    }

    .zan-tips .zan-close::after {
        -webkit-transform: rotate(-45deg);
        -moz-transform: rotate(-45deg);
        -ms-transform: rotate(-45deg);
        -o-transform: rotate(-45deg);
        transform: rotate(-45deg);
    }

    .user-icon {
        width: 25px;
        height: 25px;
        display: inline-block;
        margin-right: 2px;
        border-radius: 50%
    }
}

.night{
    .mod-zan {
        border-top-color: #1f1f1f;
        .zan-author a {
            color: #959595;
        }
        .zan-author .zan-tag {
            color: #99222c;
            border: 1px solid #99222c;
        }
        .zan-btn {
            background-color: #99222c;
            background-image: url(http://w10.hoopchina.com.cn/hybrid/static/common/widget/mod-zan/img/icon-light_e44352e.png);
            color: #959595;
        }

        .zan-list {
            background-color: #1f1f1f;
            color: #5a5a5f;
        }

        .zan-list .zan-count {
            color: #99222c;
        }

        .zan-tips {
            background-color: #85242e;
            color: #959595;
        }

        .zan-tips .zan-close:before,
        .zan-tips .zan-close:after {
            background: #959595;
        }
    }
}
</style>
