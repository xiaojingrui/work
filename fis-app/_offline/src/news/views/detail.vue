<template>
<section class="detail-wrap" v-el:container>
    <!-- <loading :show="isLoading" text="" position="absolute"></loading> -->
    <div class="artical-main-content" v-el:content v-show="!isLoading">
      <artical-title :news.sync="news"></artical-title>
      <article class="artical-content" :style="{'font-size': fontSize + 'px'}">
          <div class="artical-main-pic" v-if="news.img_m">
              <img v-if="nopic" :src="getDefaultPic()" data-src="{{news.img_m}}" />
              <img v-else :src="news.img_m" />
          </div>
         {{{news.content}}}
      </article>

      <section class="news-tags" v-if="tags.length">
          <span class="tag-title">
              标签:
          </span>
          <div class="tags-list">
              <a v-for="item in tags" :href="item.url" class="button-link" dace-node="news_tags">{{item.name}}</a>
          </div>
      </section>

      <!--赞赏-->
     <praise
        type="news"
        :author.sync="author"
        :users.sync="news.reward_rank.data"
        :user-count.sync="news.reward_rank.total_people"
        :gold-count.sync="news.reward_rank.total_dollor"
        :callname.sync="news.author_type"
        :typeid.sync="nid"
        :tips.sync="news.tips"
        v-if="!isEmpty(author) && !isEmpty(news) && news.is_reward">
     </praise>

    </div>
     <!--顶部消息-->
      <artical-comment
           is-top-comment
           title=""
           :leaguesen.sync="leaguesen"
           :username.sync="username"
           :data.sync="top_comment"
           :uid.sync="uid"
           :cid.sync="cid"
           :ft.sync="fontSize"
           :scroll-lock.sync="scrollLock"
           @toast="toast"
           v-if="top_comment.length">
     </artical-comment>

     <!--亮了-->
     <artical-comment
        title="这些评论亮了"
        :goto-view.sync="showLight"
        :leaguesen.sync="leaguesen"
        :data.sync="light"
        :uid.sync="uid"
        :cid.sync="cid"
        :puid.sync="puid"
        :typeid.sync="nid"
        :ft.sync="fontSize"
        :scroll-lock.sync="scrollLock"
        @toast="toast"
        v-if="light.length">
    </artical-comment>

    <!--广告位-->
     <card-ad
        dace="news_detailsAd"
        v-if="!isEmpty(recommend_data)"
        :url.sync="recommend_data.recommend_url"
        :pic.sync="recommend_data.img"
        :title.sync="recommend_data.title">
     </card-ad>

     <!--最新评论-->
     <div v-el:comment>
      <artical-comment
        title="最新评论"
        :goto-view.sync="showReply"
        :leaguesen.sync="leaguesen"
        :data.sync="posts"
        :uid.sync="uid"
        :puid.sync="puid"
        :cid.sync="cid"
        :typeid.sync="nid"
        :ft.sync="fontSize"
        @toast="toast"
        v-if="posts.length">
     </artical-comment>
     </div>
     <!--未加载评论或无评论-->
     <div class="news-post-loading m-reply" v-show="replyLoaded">{{!commentHasNextPage && !isLoadingMore ?'没有更多评论了' : '评论加载中...'}}</div>

      <toast :show.sync="showToast" width="14em" :time="2000" type="text">{{toastMsg}}</toast>
</section>
</template>

<script>
import {
    getNewsArticle,
    getNewsLight,
    getNewsComment,
    getNewsVote,
    getUserInfo,
    saveNewsVote
} from '../common/models'
import { getInfo, setInfo, setTitle, isAndroid, sendHideLoading } from 'common/app'
import { getFontSize } from 'common/utils'
import { golbal } from 'common/events'
import dace from 'common/dace'
import _ from 'underscore'
import * as image from 'common/image'
import $ from 'common/zepto'
import vote from 'common/vote'
import drop from 'common/drop'
import * as bridge from 'common/bridge'
import rememberPos from 'common/remember'
import animateScroll from 'common/animateScroll'

import { Loading, Toast, Praise, CardAd } from 'components'
import {
    articalTitle,
    articalComment
} from '../components'

let viewHeight = $(window).height();

export default {
    components: {
        Toast,
        Loading,
        Praise,
        CardAd,
        articalTitle,
        articalComment
    },
    data(){
        return {
            showToast: false,
            showLight: false,
            showReply: false,
            toastMsg: "",
            isLoading: true,
            isLoadingMore: false,
            replyLoaded: false,
            scrollLock: false,
            news: {},
            author: {},
            tags: [],
            surprise: [],
            recommend_data: {},
            nid : "",
            uid : "",
            cid : "",
            puid: "",
            header: "",
            nopic : 0,
            top_ncid: 0,
            load_ncid: 0,
            oldScrollTop: 0,
            articleScrollTop: 0,
            replyScrollTop: 0,
            baseReplyScrollTop: 0,
            create_time:"",
            commentHasNextPage: false,
            wasShowReply: false,
            leaguesen: "",
            entrance: "",
            username: "",
            fontSize: getFontSize(),
            light: [],
            top_comment: [],
            posts: []
        }
    },
    ready() {
        let na = getInfo()
        let self = this
        this.nopic = na.nopic
        //更新页面字体大小
        golbal.on("updateFontsize", (ft) => {
            this.fontSize = getFontSize(ft)
        })

        //更新页面夜间模式
        golbal.on("updateNightMode", (night) => {
            this.$els.content.querySelectorAll("img").forEach(item => {
                  let nSrc = image.replaceImageWithMode(item.src, night)
                  if(item.src != nSrc){
                      item.src = nSrc
                  }
            });
        });

        //滚动到亮回复, 没有就滚动到最新回复
        bridge.register("hupu.ui.reply", (res) =>{
            if(!this.wasShowReply){
                if(this.light && this.light.length){
                    this.gotoLight()
                } else{
                    this.gotoReply()
                }
            } else{
                animateScroll(this.$els.container, 300)
            }
            this.wasShowReply = !this.wasShowReply
        });

        // $(window).on("scroll", function(e){
        //    if(!self.scrollLock && self.baseReplyScrollTop > 0){
        //      let scrollTop = $(this).scrollTop()
        //      self.$nextTick(()=>{
        //         if(scrollTop < self.baseReplyScrollTop){
        //             self.articleScrollTop = Math.min(scrollTop, self.baseReplyScrollTop - viewHeight)
        //         } else{
        //             self.replyScrollTop = scrollTop
        //         }
        //      })
        //    }
        // })

        //新闻假回复
        bridge.register("hupu.ui.newsreplysuccess", (msg) => {
            this.getReplyData(msg)
            this.gotoReply()
        });

        //hash变化时，页面reload
        $(window).on("hashchange", () => {
            location.reload()
        });
    },
    methods: {
        isEmpty: _.isEmpty,
        isShowReply( reply ){
            return (_.isUndefined(reply.is_delete) && reply.audit_status != 1) || (reply.audit_status == 1 && (reply.uid == this.uid || reply.cid == this.cid ))
        },
        gotoLight(){
            this.showLight = true
            //重置状态
            setTimeout(()=>{
                this.showLight = false
            }, 100)
        },
        gotoReply(){
            this.showReply = true
            //重置状态
            setTimeout(()=>{
                this.showReply = false
            }, 100)
        },
        toast(msg){
            this.$emit('toast', msg)
        },
        getNews(){
            let na = getInfo()

            let params = {
                nid: this.nid,
                leaguesEn: this.leaguesen,
                entrance: this.entrance,
                night: na.night,
                nopic: na.nopic,
                time_zone: this.time_zone
            };

            //获取新闻正文接口
            getNewsArticle
                .bind(params)
                .execute(({data}) => {
                    setTitle(data.news.title)
                    this.news = data.news
                    this.surprise = data.surprise || []

                    //赞赏使用..
                    if(this.news.is_reward){
                        this.author = {
                            "header": data.news.author_header,
                            "nickname" : data.news.author_nickname,
                            "uid" : data.news.author_puid
                        }
                    }

                    this.username = data.user_name
                    this.uid = data.uid
                    this.cid = data.cid
                    this.puid = `${data.puid}`
                    //设置全局变量
                    setInfo('isadmin', !!parseInt(data.is_admin))

                    this.tags = !_.isEmpty(data.news.tags) ? data.news.tags : []
                    this.recommend_data = !_.isEmpty(data.news.recommend_data) ? data.news.recommend_data[0] : {}

                    //通知NA隐藏Loading
                    sendHideLoading()

                    this.$nextTick(() => {
                        this.isLoading = false
                        this.bindEvent()
                        this.getNewsComments()
                    });
                }, () => {
                    this.isLoading = false

                    //通知NA隐藏Loading
                    sendHideLoading()
                });
        },
        bindEvent(){
            let self = this

            //滚动加载评论
            this.bindScroll();

            //新闻彩蛋
            if(this.surprise && this.surprise.length){
                let rand = (this.surprise.length * Math.random())|0;
                let surpriseImg = this.surprise[rand];
                drop.create(surpriseImg, 80);
                setTimeout(function(){
                    drop.remove();
                }, 5000);
            }

            //展示投票
            $(this.$els.content).find("span._vote").each(function(idx, elem){
               vote({
                   type:'news',
                   elem: elem,
                   typeid: self.nid,
                   getVote: getNewsVote,
                   saveVote: saveNewsVote,
                   scope: self
               })
            });

            //记录阅读位置
            rememberPos.init(this.$els.content, this.nid, "remeber_news")

            //渲染GIF
            image.renderGifs($(this.$els.content));

            $(this.$els.content).delegate("img", "click", function(e) {
                  var currentTarget = e.currentTarget;
                  var realSrc = null;
                  if (currentTarget.getAttribute("data-src")) {
                    realSrc = currentTarget.getAttribute("data-src");
                    currentTarget.src = realSrc;
                    currentTarget.removeAttribute("data-src");
                  } else {
                    if (!currentTarget.getAttribute("data-gif")) {
                      var imgs = $(self.$els.content).find("img");
                      var imgsNow = [];
                      //去除img为头像的图片
                      imgs.each(function(index,item) {
                        if(!$(this).hasClass("user-icon")) {
                          imgsNow.push(item)
                        }
                      })
                      image.handleCreateAlbum(currentTarget, imgsNow);
                    }
                  }

                  // gif二次点击统计
                  if ($(this).attr("alt").indexOf("gif") != -1) {
                    dace.send("gif_secondclick");
                  }

                  if (currentTarget.getAttribute("data-gif")) {
                    image.handlerClickGif(currentTarget);
                  }
            })
        },
        bindScroll(){
            let timer = null
            $(window)
                .off('scroll.refresh')
                .on('scroll.refresh', () => {
                    timer = setTimeout(() => {
                        this.getLoadMore()
                    }, 300);
                });
        },
        filterReply(list){
            let arr = []
            if(_.isArray(list)){
                list.forEach(item => {
                    if(this.isShowReply(item)){
                        arr.push(item)
                    }
                })
            }
            return arr
        },
        getNewsComments(){
            let params = {
                nid: this.nid
            }
            if(this.top_ncid !== 0){
                params.top_ncid = this.top_ncid
            }

            getNewsComment
                .bind(params)
                .execute(({data}) => {

                    if(!_.isEmpty(data.top_comment)){
                        this.top_comment = this.filterReply(data.top_comment)
                    }

                    if(!_.isEmpty(data.light_comments)){
                        this.light = this.filterReply(data.light_comments)
                    }

                    if(!_.isEmpty(data.data)){
                        this.posts = this.filterReply(data.data)
                    }
                    this.replyLoaded = true
                    this.commentHasNextPage = !!data.hasNextPage

                    if(!_.isEmpty(data.data) && data.data.length > 0){
                      this.load_ncid = data.data[data.data.length - 1].ncid;
                      this.create_time = data.data[data.data.length - 1].create_time;
                    }

                    //渲染完，设置评论顶部高度
                    // setTimeout(() => {
                    //     let replyContainer = document.querySelector(".m-reply")
                    //     this.replyScrollTop = _.isElement(replyContainer) ? replyContainer.offsetTop : 0
                    //     this.baseReplyScrollTop = this.replyScrollTop
                    // }, 800)
            })
        },
        getLoadMore(){
            if(!this.commentHasNextPage){
                return;
            }
            let scrollTop = $(window).scrollTop(),
                viewTop = viewHeight + scrollTop,
                contentHeight = $(document).height();

            if(contentHeight <= viewTop + 10 && this.oldScrollTop < scrollTop && !this.isLoadingMore){
                this.isLoadingMore = true
                this.getMoreComments(()=>{
                    this.isLoadingMore = false
                    //如果已经没有要加载的数据，移除window.scroll事件
                    if(!this.commentHasNextPage){
                        $(window).off("scroll.refresh")
                    }
                })
            }
            this.oldScrollTop = scrollTop
        },
        getMoreComments(loaded){
            let params = {
                nid: this.nid,
                ncid: this.load_ncid,
                create_time: this.create_time
            }
            getNewsComment.bind(params).execute(({data}) => {


                if(!_.isEmpty(data.data)){
                    this.posts = this.posts.concat(this.filterReply(data.data))
                }

                this.commentHasNextPage = !!data.hasNextPage;
                if(!_.isEmpty(data.data) && data.data.length > 0){
                  this.load_ncid = data.data[data.data.length - 1].ncid;
                  this.create_time = data.data[data.data.length - 1].create_time;
                }

                loaded && loaded()
            })
        },
        getDefaultPic(){
            let na = getInfo()
            let night = na.night
            if(night){
                return 'http://w10.hoopchina.com.cn/games/images/bbs-night-nopic.png'
            } else{
                return 'http://b10.hoopchina.com.cn/games/images/news_nopic_day@2x.png'
            }
        },
        getReplyData(msg) {
            //无昵称用户获取昵称
            if (this.username == '' || this.header == '') {
              getUserInfo.execute(({data}) => {
                  if (data.result && data.is_login) {
                    this.username = data.result.nickname;
                    this.header = data.result.header;
                    this.puid = data.result.puid;
                    this.uid = data.result.uid;
                  }
                  this.appendReply(msg);
              })
            } else {
              this.appendReply(msg);
            }
        },
        appendReply(msg){
            let content = msg.content.replace(/\n/g, '<br />');
            let replyData = {
              "from": "0",
              "ncid": msg.ncid,
              "light_count": 0,
              "unlight_count": 0,
              "uid": this.uid,
              "user_name": this.username || "神秘球迷",
              "content": content,
              "create_time": "刚刚",
              "cid": this.cid,
              "lighted": 0,
              "format_time": "刚刚",
              "header": this.header,
              "puid": this.puid
            }
            // 引用
            if (msg.isCallFromH5 == 1) {
              replyData.quote_data = window.tmpQuoteData
            }

            //最新评论最前面..
            this.posts.unshift(replyData)
        }
    },
    events:{
        'toast'(msg){
            this.showToast = true
            this.toastMsg  = msg
        }
    },
    route:{
        data ({to, next}) {
            this.nid = this.$route.query.nid
            this.top_ncid = this.$route.query.top_ncid || 0
            this.leaguesen = this.$route.query.leaguesEn || ""
            this.entrance = this.$route.query.entrance   || ""
            this.time_zone = this.$route.query.time_zone || "Asia/Shanghai"
            this.fontSize = getFontSize(this.$route.query.ft)

            this.getNews()
        }
    }
}
</script>

<style lang="less">
@import "../styles/detail.less";
</style>
