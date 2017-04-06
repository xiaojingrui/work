<template>
<div class="m-reply" v-el:container>
    <div class="title-out" v-if="title && page == 1">
        <div class="title" v-el:title>
            <h2>{{title}}</h2>
        </div>
    </div>
    <div class="reply-inner" v-el:reply>
        <div v-if="data.length">
            <dl v-for="(index, item) in data" class="reply-list" :class="{'reply-fold': isRealFoldContent(item)}" data-pid="{{item.pid}}" data-uid="{{item.puid}}" data-username="{{item.userName}}" data-floor="{{item.floor}}">
                <dd class="operations-user" v-if="!isFoldContent(item)">
                    <a :href="getUserLink(item.puid)" class="user-avatar" dace-node="postuser">
                        <img :src="item.userImg" class="J-user-avatar-img" alt="{{item.userName}}" />
                        <span class="mod-mask mask"></span>
                    </a>
                    <div class="user-info">
                        <div class="user-name clearfix">
                            <div class="fl">
                                <a class="J_name_word" :href="getUserLink(item.puid)">{{item.userName}}</a>
                                <i v-if="item.puid == authorPuid">楼主</i>
                                <a :href="getUserLink(item.puid)" class="certification" v-if="item.certurl">
                                    <img :src="item.cert.image" height="22" />
                                </a>
                            </div>
                        </div>

                        <div class="source-left">
                            <span class="floor" v-if="item.floor">{{item.floor}}楼</span>
                            <span class="postdate" v-if="item.time">{{item.time}}</span>
                        </div>
                    </div>
                    <span class="reply-light">亮了({{item.light_count||0}})</span>
                </dd>
                <dt class="reply-content" v-if="!isFoldContent(item)" :style="{'font-size': (ft - 2) + 'px'}">
                    <div class="reply-quote-content" v-if="item.quote && isArray(item.quote) && item.quote.length > 0">
                            <div class="reply-quote-delete" v-if="item.quote_deleted">
                                {{{item.quote[0].content}}}
                            </div>
                            <div v-else>
                                <div class="reply-quote-fold" dace-node="clickfoldedquote" v-if="isQuoteFoldContent(item)" @click="item.qoute_isFold = true">
                                    引用内容被灭过多，已被折叠
                                </div>
                                <div v-else>
                                    <div class="reply-quote-hd">
                                        {{{item.quote[0].header[0]}}}
                                    </div>
                                    <div v-if="item.quote[0].togglecontent">
                                        <div class="short-quote-content J_shortContent">
                                            {{{filterSmile(item.quote[0].togglecontent)}}}
                                        </div>
                                        <div class="reply-quote-bd J_allContent">
                                            {{{filterSmile(item.quote[0].content)}}}
                                        </div>
                                        <div class="button-open-inner">
                                            <a class="button-open J_buttonOpenAll" title="展开">显示全部 <s class="arrow"></s></a>
                                        </div>
                                    </div>
                                    <div class="short-quote-content" v-else>
                                        {{{filterSmile(item.quote[0].content)}}}
                                    </div>
                                </div>
                            </div>
                    </div>

                    <div class="current-content J_contentParent">
                        <span class="short-content">
                            {{{filterSmile(item.content)}}}
                        </span>
                    </div>
                    <div class="praise-reply J-praise-{{item.pid}}" v-if="item.praise" dace-node='replyreward_people'>
                        已有<span class="praise-person">{{item.praise.list.userCount}}</span>个JRs赞赏了<span class="praise-count">{{item.praise.list.goldCount}}</span>虎扑币 &gt;
                    </div>
                </dt>
                <dd class="reply-content-fold" dace-node="clickunfoldedreply" v-if="isFoldContent(item)" @click="item.isFold = true" data-index="{{index}}">该回帖被灭过多，已被折叠</dd>
            </dl>
        </div>
        <div class="reply-empty" v-else>{{postCount == 0 ? '暂无回复':'回复加载中...'}}</div>
    </div>
    <div class="general-reply-more" v-if="page >= totalPage && isPosts && totalPage >= 1 && !isOwner && lastPostCount > 0">
        轻击瞅瞅新回复来了没
    </div>

    <confirm :show.sync="confirmShow" title="确认要灭了该回帖？" @on-confirm="onConfirmRuLight" cancel-text="取消" confirm-text="确认">
      <p style="text-align:center;">仅本次操作有提示，请谨慎使用灭了功能，只可对低质量、无意义、不友善内容点灭，否则可能被视作恶意点灭并受到相应惩罚。</p>
    </confirm>
</div>
</template>

<script>
import _ from 'underscore'
import $ from 'common/zepto'
import popupInstance from 'common/popup'
import dace from 'common/dace'
import { checkLogin, getInfo, isIOS } from 'common/app'
import * as bridge from 'common/bridge'
import * as image from 'common/image'
import * as util from 'common/utils'
import { Confirm } from 'components'
import * as BBSModel from '../common/models'
import Store from 'common/store'
import animateScroll from 'common/animateScroll'

let _last = null,
    _current = null,
    _tid,
    _pid,
    _uid,
    _username,
    _floor,
    _content;

let _unlightStore = new Store("hupu_bbs_unlight")

let StoreInstance = {
    hasUnLight: function(){
		var markStatus = _unlightStore.getValue();
		return !!parseInt(markStatus);
	},
	markUnLight: function(){
		if(this.hasUnLight())return;
		_unlightStore.setValue(1);
	}
}

let initPopupStatus = false

//Popup需要保持唯一实例
function initPopup(right, self){
  //弹层初始化
  if(!initPopupStatus){
    initPopupStatus = true
    popupInstance.initBBS(right)

    //帖子回复
    popupInstance.on("reply", function(){
        //折叠无法回复
        if(_current && _current.hasClass('reply-fold')){
            self.$emit("toast", "该回帖已被折叠，无法进行该操作");
            return;
        }
        var loginEvent = function(){
            if(_tid && _pid && _uid){
                bridge.send("hupu.ui.bbsreply", {
                    open: true,
                    extra:{
                        tid: _tid,
                        pid: _pid,
                        uid: _uid,
                        username : _username,
                        floor: _floor,
                        content: _content
                    }
                });
            }
        }
        checkLogin(loginEvent);
    });

    //回帖赞赏回调
    $(document).on("bbs:replyzan", function(e, data){
        var tpl = _.template(['<div class="praise-reply J-praise-<%=pid%>" >',
                        '已有<span class="praise-person">1</span>个JRs赞赏了<span class="praise-count"><%=count%></span>虎扑币 &gt;',
                    '</div>'].join(''));
        var $praiseCon = $(".J-praise-" + data.pid);
        if($praiseCon.size()){
           var userCount = +($praiseCon.find(".praise-person").text()) + 1;
           var goldCount = parseInt($praiseCon.find(".praise-count").text()) + parseInt(data.amount);
           $praiseCon.find(".praise-person").text(userCount);
           $praiseCon.find(".praise-count").text(goldCount);
        } else{
           $("dl[data-pid='"+ data.pid +"']").find(".reply-content").append(tpl({pid: data.pid, count: data.amount}));
        }
    });
    //回复赞赏
    popupInstance.on("zan", function(){
        //折叠无法赞赏
        if(_current && _current.hasClass('reply-fold')){
            self.$emit("toast", "该回帖已被折叠，无法进行该操作");
            return;
        }
        var loginEvent = function(){
            if(_current && _current.hasClass("reply-active")){
                _current.removeClass("reply-active");
            }
            bridge.send("hupu.ui.admire", {
                type: "bbsreply",
                typeid : _tid,
                extra:{
                    "fid": self.fid,
                    "pid": _pid,
                    "uid": _uid,
                    "nickname": _username,
                    "content": _content
                }
            });
        }
        checkLogin(loginEvent);
    });

    //回帖内容举报
    popupInstance.on("report", function(){
        let loginEvent = function(){
            if(_tid && _pid){
                bridge.send("hupu.ui.report", {
                    open: true,
                    extra:{
                        tid: _tid,
                        pid: _pid,
                        fid: self.fid
                    }
                });
            }
        }
        checkLogin(loginEvent);
    });

    //回帖点亮
    popupInstance.on("light", function(){
        self.addLight(_pid, function(count){
            //接口异常返回null
            if(!count){
                count = _current.find(".reply-light").text().match(/\d+/);
                count = count && count.length == 1 ? (parseInt(count[0], 10) + 1) : 1;
            }
            _current.find(".reply-light").text("亮了("+ count +")");
            util.count(_current.find(".reply-light"), "+1", "right");
            self.$emit("toast", "点亮成功");
        });
    });

    //回帖点灭
    popupInstance.on("rulight", function(){
        self.rulightCallback = function(count){
            //接口异常返回null
            if(!count){
                count = _current.find(".reply-light").text().match(/\d+/);
                count = count && count.length == 1 ? (parseInt(count[0], 10) + 1) : 1;
            }
            _current.find(".reply-light").text("亮了("+ count +")");
            util.count(_current.find(".reply-light"), "-1", "right");
            self.$emit("toast", "已点灭");
        }
        self.addRuLight(_pid);
    });
  }
}

export default {
    components:{
       Confirm
    },
    props:{
        page: Number,
        pageTotal: Number,
        lastPostCount: Number,
        data: Array,
        title: String,
        authorPuid: String,
        fid: String,
        tid: String,
        pid: String,
        isOwner: {
          type: Boolean,
          default: false
        },
        unlightsEnable: {
          type: Boolean,
          default: false
        },
        isPosts: {
          type: Boolean,
          default: false
        },
        hasPraise: {
          type: Boolean,
          default: false
        },
        titleFixed:{
          type: Boolean,
          default: false
        },
        showLast:{
          type: Boolean,
          default: false
        },
        ft: Number,
        lastPid: String,
        totalPage: {
          type: Number,
          default: 1
        },
        isLoading:{
          type: Boolean,
          default: true
        },
        confirmShow: false,
        isAdmin: Boolean,
        postCount: {
          type: Number,
          default: 0
        }
    },
    ready(){
        _tid = this.tid
        this.$nextTick(() => {
            this.bindEvent()
            this.titleFixedHandle()
        })
    },
    watch: {
       isLoading(newLoading) {
         this.$nextTick(()=>{
             if(!newLoading){
               //渲染GIF
               image.renderGifs($(this.$els.reply), "bbs");

               //跳转指定楼层
               if(this.pid){
                 this.findFloor(this.pid)
               }

               //新回复，跳转到页面最下方
               if(this.showLast){
                   let target = $(this.$els.reply).find("dl").last().get(0)
                   if(_.isElement(target)){
                       animateScroll(target, 300)
                   }
               }

               //滚动到全部回复区域
               //只看楼主, 第一页自动跳到全部回复那.
               if(this.isOwner && this.isPosts && this.page == 1){
                     animateScroll(this.$els.container, 300);
               }

             }
         })
       }
    },
    methods:{
        isArray: _.isArray,
        filterSmile: image.filterSmile,
        getUserLink (puid){
            if(parseInt(puid, 10) > 0){
                return `kanqiu://people/${puid}`
            }else{
                return 'javascript:void(0)'
            }
        },
        isFoldContent( reply){
            return (!isNaN(reply.light_count) && parseInt(reply.light_count) < -9) && !reply.isFold
        },
        isQuoteFoldContent( reply ){
            return (!isNaN(reply.quote_light_count) && parseInt(reply.quote_light_count) < -9) && !reply.qoute_isFold
        },
        isRealFoldContent( reply, key = "light_count"){
            return (!isNaN(reply[key]) && parseInt(reply[key]) < -9)
        },
        findFloor: function(pid){
           if(!pid) return
           let target = $(this.$els.reply).find("dl[data-pid='"+ pid +"']");
           if(target.size()){
               animateScroll(target[0], 300)
           }
        },
        bindEvent(){
            let na = getInfo()
            let nopic = na.nopic
            let self = this
            let $replyContainer = $(this.$els.reply);

            //渲染GIF
            image.renderGifs($replyContainer, "bbs");

            //初始化popup和封禁管理
            initPopup({
                hasRulight: !na.islogin || this.unlightsEnable,
                hasZan: this.hasPraise
            }, this);

            //加载更多回复
            $(this.$els.container).delegate(".general-reply-more", "click", function(e){
                self.getLastPost(function(pid){
                    if(pid != self.lastPid){
                        bridge.send("hupu.ui.updatepagestatus");
                        if(self.lastPostCount < 20){
                            let oldPid = self.lastPid;
                            self.$emit('getpost', self.page, function() {
                                self.findFloor(oldPid);
                            })
                        } else{
                            self.$emit('getpost', self.page + 1, function() {
                                self.findFloor(self.lastPid);
                                self.lastPid = pid;
                            })
                        }
                    }
                });
            });

            //回复区域事件
            $replyContainer.delegate(".reply-list", "click", function(e){
                //ios只能使用a链接的默认行为
                if(!isIOS){
                    e.stopPropagation();
                    e.preventDefault();
                }
                let target = e.target;
                let currentTarget = $(target);
                let tagName = target.tagName.toLowerCase();
                //第一次展开
                if(currentTarget.hasClass('reply-content-fold')
                || currentTarget.hasClass('reply-quote-fold')){
                    popupInstance.hide();
                    return
                }

                //评论展开收起
                if(tagName === 'a' && currentTarget.hasClass("J_buttonOpenAll")){
                    var parent = currentTarget.parents(".reply-quote-content");
                    parent.find(".J_shortContent").hide();
                    parent.find(".J_allContent").show();
                    currentTarget.hide();
                    return;
                }

                if((tagName === 'a' || target.parentNode.tagName.toLowerCase() === "a")){
                    setTimeout(function(){
                         popupInstance.hide();
                    }, 10);
                    if(!isIOS){
                        var href = currentTarget.attr("href") || $(target.parentNode).attr("href");
                        location.href = href;
                        return;
                    }
                }
                if(tagName === 'img'){
                    if(currentTarget.hasClass("J-user-avatar-img") || currentTarget.hasClass("emoji")){
                        return;
                    }
                    //点击gif图的时候计算图片大小，防止gif角标错位
                    if(target.getAttribute("data-gif") && target.getAttribute("data-src")) {
                        var realSrc = target.getAttribute("data-src");
                        $(currentTarget).on("load", function() {
                          image.imgResize(currentTarget, "reply");
                        });
                        target.src = realSrc;
                    }
                    if(target.getAttribute("data-src")){
                        var realSrc = target.getAttribute("data-src");
                        target.src = realSrc;
                        target.removeAttribute("data-src");
                    } else{
                        if(!target.getAttribute("data-gif")){
                            var imgs = currentTarget.parents(".reply-content").find("img");
                            image.handleCreateAlbum(target, imgs);
                        } else{
                            image.handlerClickGif(target, nopic);
                        }
                    }
                    return;
                }

                let touch = e.touches ? e.touches[0] : e;
                let top = Number(touch.pageY);
                _current = $(e.currentTarget);

                if(_current.hasClass("reply-active")){
                    _current.removeClass("reply-active");
                } else{
                    if(_last !== null){
                        _last.removeClass("reply-active");
                    }
                    _last = _current;
                    _current.addClass("reply-active");
                    _uid = _current.data("uid");
                    _pid = _current.data("pid");
                    _username = _current.data("username");
                    _floor = _current.data("floor");
                    _content = _current.find(".J_contentParent").text().trim();
                }
                dace.send("replyOperation");

                //评论赞赏列表
                if(currentTarget.hasClass("praise-reply")){
                     if(_current && _current.hasClass("reply-active")){
                        _current.removeClass("reply-active");
                     }
                    bridge.send("hupu.ui.admirelist", {
                        type : "bbsreply",
                        typeid : _tid,
                        extra: {
                            fid : self.fid,
                            pid : _pid,
                            uid : _uid,
                            nickname: _username,
                            content: _content
                        }
                    });
                    return;
                }

                popupInstance.update(top, e.currentTarget);
            });

        },
        //标题置顶显示=>lazyload
        titleFixedHandle : function() {
            if(!this.titleFixed) return
            if(this.titleFixedStatus) return
            this.titleFixedStatus = true;

            let na = getInfo()
            let self = this
            let pics = $("body").find("img.lazy");
            //有图模式下执行
            if(!na.nopic) {
                pics.each(function(idx, img) {
                    image.imgResize(img);
                })
            }

            $(window).on("touchmove scroll", () => {
                let contentHeight = $(".detail-content").height() || 0,
                    listHeight = $(this.$els.container).height() || 0,
                    scrollTop = $(window).scrollTop();

                if(scrollTop >= contentHeight && scrollTop < contentHeight + listHeight - 36) {
                    $(this.$els.title).addClass("fixed")
                }else{
                    $(this.$els.title).removeClass("fixed")
                }
            });
        },
        filterSmile: image.filterSmile,
        //回帖点亮
        addLight(pid, callback){
            let loginEvent = () => {
                BBSModel
                    .addPostLight
                    .bind({
                       tid: this.tid,
                       fid: this.fid,
                       pid: _pid
                    })
                    .execute(({data})=>{
                        if(data && data.status === 200){
                           callback && callback(data.result);
                        } else{
                           let msg = data.error ? data.error.text : "";
                           this.$emit("toast", msg);
                        }
                    }, ({data})=>{
                        let msg = data.error ? data.error.text : "";
                        this.$emit("toast", msg);
                    });
            }
            checkLogin(loginEvent)
        },
        //回帖点灭
        addRuLight(pid){
            if(getInfo().islogin){
                //如果不存在点灭
                if(!StoreInstance.hasUnLight()){
                  this.confirmShow = true
                  //弹出一次，不再提示用户.
                  StoreInstance.markUnLight();
                } else{
                  this.onConfirmRuLight()
                }
            } else{
                checkLogin(this.onConfirmRuLight);
            }
        },
        onConfirmRuLight(callback){
            BBSModel
                .addPostRulight
                .bind({
                   tid: this.tid,
                   fid: this.fid,
                   pid: _pid
                })
                .execute(({data})=>{
                    if(data && data.status === 200){
                       this.rulightCallback && this.rulightCallback(data.result);
                    } else{
                       let msg = data.error ? data.error.text : "";
                       this.$emit("toast", msg);
                    }
                }, ({data})=>{
                    let msg = data.error ? data.error.text : "";
                    this.$emit("toast", msg);
                });
        },
        //拉取最新的回复
        getLastPost(callback){
            BBSModel
              .getLastPost
              .bind({tid: this.tid})
              .execute(({data})=>{
                  if(data && data.status === 200
                          && data.result
                          && data.result.last_pid
                          && data.result.last_pid != this.lastPid
                  ){
                     dace.send("newreplynew");
                     this.totalPage = parseInt(data.result.all_page, 10);
                     callback(data.result.last_pid);
                  } else{
                     dace.send("newreplynull");
                     this.$emit("toast", "暂时没有新回复哦~");
                  }
              })
        }
    }
}
</script>

<style lang="less">
@import "../styles/reply.less";
@import "../styles/tips.less";
</style>
