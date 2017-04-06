<template>
<div class="m-reply" :class="{'jump-reply': isTopComment}" v-if="data.length" v-el:reply>
    <div class="title" v-if="title.length">
        <h2>{{title}}</h2>
    </div>

    <div class="reply-inner" v-el:list>
      <dl v-for="item in data"
            class="reply-list"
            :class="{'reply-list-hide': !isUndefined(item.is_hide) && item.is_hide != -1}"
            data-hide="{{item.is_hide}}"
            data-ncid="{{item.ncid}}"
            data-uid="{{item.uid}}"
            data-username="{{item.user_name}}"
            data-lighted="{{item.lighted}}">

            <dd class="reply-hide" v-if="!isUndefined(item.is_hide) && item.is_hide != -1" @click="item.is_hide = -1">
                该评论被灭过多，已被折叠
            </dd>
            <dd class="operations-user" v-if="isUndefined(item.is_hide) || item.is_hide == -1">
                <div class="user-avatar">
                    <a :href="getUserLink(item.puid)" :class="{'J_preventName': isUserLink(item.puid)}">
                        <img :src="item.header" alt="" >
                        <span class="mod-mask mask"></span>
                    </a>
                </div>
                <div class="user-info">
                    <div class="user-name">
                        <a :href="getUserLink(item.puid)" :class="{'J_preventName': isUserLink(item.puid)}">
                            {{item.user_name}}
                        </a>
                    </div>
                    <div class="user-other">
                        <span class="times">
                            {{item.format_time}}
                        </span>
                    </div>
                </div>
                <div class="operations">
                    <a href="javascript:" class="button-light">
                        亮了(<span class="J_ligthCount">{{item.light_count - item.unlight_count}}</span>)
                    </a>
                </div>
            </dd>
            <dt class="reply-content" :style="{'font-size': (ft - 2) + 'px'}">
                <div v-if="!!item.quote_data">
                    <div class="reply-quote-delete" v-if="!isUndefined(item.quote_data.is_delete)">
                        该评论由于违规，已被删除
                    </div>
                    <div class="reply-quote-fold" v-if="isUndefined(item.quote_data.is_delete) && !isUndefined(item.quote_data.audit_status)">
                        该评论可能违规，已被隐藏
                    </div>
                    <div class="reply-quote-hide" v-if="isUndefined(item.quote_data.audit_status) && !isUndefined(item.quote_data.is_hide)" @click="item.quote_data.is_hide = undefined">
                        该评论被灭过多，已被折叠
                    </div>
                    <div class="reply-quote-content J_contentParent"
                        v-if="isUndefined(item.quote_data.is_delete)
                          &&  isUndefined(item.quote_data.audit_status)
                          &&  isUndefined(item.quote_data.is_hide)"
                        :style="{display: !isUndefined(item.quote_data.is_hide) ? 'node' : 'block'}">
                        <div class="reply-quote-hd">
                            {{item.quote_data.user_name}}
                        </div>

                        <div v-if="!isUndefined(item.quote_data.short_content)">
                            <div class="short-quote-content J_quoteShortContent">
                                {{{item.quote_data.short_content}}}
                            </div>
                            <div class="reply-quote-bd J_quoteAllContent">
                                {{{item.quote_data.content}}}
                            </div>
                            <div class="button-open-inner">
                                <a href="javascript:" class="button-open J_buttonOpenAll" title="展开" data-type="replyQuoteButtonOpen" dace-node="comment_expand">显示全部 <s class="arrow"></s></a>
                            </div>
                        </div>
                        <div class="short-quote-content" v-else>
                            {{{item.quote_data.content}}}
                        </div>
                   </div>
               </div>

                <div class="current-content J_contentParent J_currentContent">
                    <span class="short-content">
                        {{{item.content}}}
                    </span>
                </div>
            </dt>
        </dl>
    </div>
</div>
</template>

<script>
import _ from 'underscore'
import $ from 'common/zepto'
import popupInstance from 'common/popup'
import { addLightNewsComment } from '../common/models'
import { checkLogin, getInfo } from 'common/app'
import * as bridge from 'common/bridge'
import purview from '../common/purview'
import * as util from 'common/utils'
import animateScroll from 'common/animateScroll'

let _last = null;
let initPopupStatus = false

//Popup需要保持唯一实例
function initPopup(scope){
  //弹层初始化
  if(!initPopupStatus){
    initPopupStatus = true
    let isAdmin = getInfo()['isadmin']
    popupInstance.initNews(isAdmin);
    //回复
    popupInstance.on("reply", function(target) {
         let $target = $(target);
         let replyEvent = function() {
            let data = {
                ncid: $target.attr('data-ncid'),
                uid: $target.attr('data-uid'),
                username: $target.attr('data-username')
            }
            //临时引用内容
            window.tmpQuoteData = {
              user_name: $target.attr('data-username'),
              content: $.trim($target.find('.short-content').html())
            }
            // 新闻回复
            data.nid = scope.typeid;
            bridge.send("hupu.ui.newsreply", {
                open: true,
                extra: data
            });

        }
        checkLogin(replyEvent)
    });

    //举报
    popupInstance.on("report", function(target) {
        let ncid = $(target).attr('data-ncid');
        let loginEvent = function(){
            bridge.send("hupu.ui.report", {
                open: true,
                extra: {
                    ncid: ncid
                }
            });
        }
        checkLogin(loginEvent)
    });

    //点亮
    popupInstance.on("light", function(target) {
        let ncid = $(target).attr('data-ncid');
        let setLightHandler = function(){
            scope.setLight($(target), ncid, 1);
        };
        checkLogin(setLightHandler);
    });
    //点灭
    popupInstance.on("rulight", function(target) {
        let ncid = $(target).attr('data-ncid');
        let setReLightHandler = function(){
            scope.setLight($(target), ncid, 2);
        };
        checkLogin(setReLightHandler);
    });


    if(isAdmin){
        purview.init(popupInstance, scope);
    }
  }
}

export default {
    props:{
        page: String,
        isTopComment: {
            type: Boolean,
            default: false
        },
        gotoView:{
            type: Boolean,
            default: false
        },
        data: Array,
        title: String,
        uid: String,
        cid: String,
        puid: String,
        typeid: String,
        scrollLock: Boolean,
        ft: {
            type: Number,
            default(){
                return getInfo().fontSize
            }
        },
        isadmin: {
           type: Boolean,
           default: false
        },
        page: 0,
        leaguesen: String
    },
    ready(){
        addLightNewsComment.resetUrl(`/${this.leaguesen||'nba'}/lightNewsComment`)

        this.$nextTick(() => {
            this.bindEvent()
        })
    },
    methods:{
        isUndefined: _.isUndefined,
        bindEvent(){
            let $replyContainer = $(this.$els.reply);
            //初始化popup和封禁管理
            initPopup(this)

            $replyContainer.on("click", function(e) {
              let target = e.target;
              let $target = $(target);
              let $parentTarget = $target.hasClass('.reply-list') ? $target :
                $target.parents('.reply-list');
              let type = target.getAttribute('data-type');
              // 默认评论显示
              if (type && type == "replyHide") {
                $parentTarget.removeClass('reply-list-hide');
                return;
              }
              // 默认引用评论显示
              if (type && type == "replyQuoteHide") {
                $parentTarget.find('.J_contentParent').show();
                $target.hide();
                return;
              }
              // 显示全部
              if (type && type == "replyQuoteButtonOpen") {
                $parentTarget.find('.J_quoteAllContent').show();
                $parentTarget.find('.J_quoteShortContent').hide();
                $target.hide();
                return;
              }

              //点击用户头像
              let parentNode = $target.parent();
              if ( $target.hasClass('J_preventName') || parentNode.hasClass('J_preventName') ){
                    setTimeout(() => {
                      popupInstance.hide();
                    }, 10);
              }

              //点击某条评论
              if($parentTarget.size()){
                  let extra = {};
                  //该评论被灭过多，回复评论隐藏
                  if($parentTarget.attr('data-hide')){
                    extra.hidereply = true;
                  }
                  //点亮点灭的状态传给评论操作框
                  if($parentTarget.attr('data-lighted')){
                     extra.lighted = $parentTarget.attr("data-lighted");
                  }
                  //再次被点击
                  if ($parentTarget.hasClass('reply-active')) {
                    $parentTarget.removeClass("reply-active");
                  } else {
                    if (_last !== null) {
                      _last.removeClass("reply-active");
                    }
                    _last = $parentTarget;
                    $parentTarget.addClass("reply-active");
                  }
                  let touch = e.touches ? e.touches[0] : e;
                  let top = Number(touch.pageY);
                  popupInstance.update(top, $parentTarget.get(0), extra);
              }else{
                  //点击评论之外.
                  popupInstance.hide();
              }
            });
        },
        showQuoteStyle(status){
            if(status){
                return {'display':'none'}
            } else{
                return ''
            }
        },
        getUserLink (puid){
            if(this.isUserLink(puid)){
                return `kanqiu://people/${puid}`
            }
            return 'javascript:void(0)'
        },
        isUserLink(puid){
            if(parseInt(puid, 10) > 0){
                return true
            }
            return false
        },
        /**
         * 点亮点灭
         * @param $target 评论容器
         * @param ncid 评论nicd
         * @param type 1为点亮，2为点灭
         */
        setLight($target, ncid, type){
            addLightNewsComment
                .bind({nid: this.typeid, ncid, type})
                .execute(({data})=>{
                    if (data.error && data.error.text) {
                      this.$emit("toast", data.error.text);
                      return;
                    }

                    let count = -1;
                    let tipText = '-1';

                    if (type && type === 1) {
                      count = 1;
                      tipText = '+1';
                      $target.attr('data-lighted', 1);
                    } else {
                      $target.attr('data-lighted', 2);
                    }

                    let $lightCount = $target.find('.J_ligthCount');
                    if (data.result == 1) {
                      $lightCount.text(parseInt($lightCount.text()) + count);
                      util.count($target, tipText);
                    }
                });
        }
    },
    watch: {
        gotoView( val ){
            if(val){
                this.scrollLock = true
                animateScroll(this.$els.reply, 300, {
                    onFinish: () => {
                        this.scrollLock = false
                    }
                })
            }
        }
    }
}
</script>

<style lang="less">
@import "../styles/reply.less";
</style>
