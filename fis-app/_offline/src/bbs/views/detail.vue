<template>
<section class="detail-wrap">
    <!-- <loading :show="isLoading" text="" position="absolute"></loading> -->
    <div class="detail-error" v-if="isError">
        <p>{{errorText}}</p>
    </div>
    <section class="detail-content" v-if="page == 1 && !isError && !isLoading">
        <p class="tips" v-if="!isEmpty(merge_title)"><em></em>{{merge_title}}</p>
        <header class="artical-title" v-el:header>
            <h1 class="headline">{{title}}</h1>
            <div class="artical-info">
                <span class="times">{{time}} 阅读 {{hits}}</span>
                <span class="post-board">
                    <em v-if="isAdmin">版务操作
                        <select class="J-bbsrecommend-manage">
                            <option value="1" v-if="!is_recommend_filter">隐藏推荐</option>
                            <option value="-1" v-if="is_recommend_filter">取消隐藏推荐</option>
                            <option value="0" selected="selected">取消</option>
                        </select>
                    </em>
                    <a :href="'kanqiu://bbs/board/' + fid" dace-node="postBoard" v-text="forum.name"></a>
                </span>
            </div>
            <div class="line"></div>
        </header>
        <article class="article-content">
            <div class="article-author clearfix">
                <a :href="'kanqiu://people/' + author_puid" dace-node="postuser" class="author_title"><img :src="userImg" class="author-icon J-user-avatar-img" /> {{username}}
                    <span class="mod-mask mask"></span>
                </a>
                <a :href="'kanqiu://people/' + author_puid" class="certification" v-if="certurl && certinfo">
                    <img :src="certimage" height="22" />
                    <span>{{certinfo}}</span>
                </a>
            </div>
            <div v-el:content class="J-article-content" :style="{'font-size': fontSize + 'px'}">{{{filterSmile(content)}}}</div>
        </article>

          <!--赞赏-->
          <praise
            type="bbs"
            callname="楼主"
            :author.sync="author"
            :users.sync="praiseData.list.goldUsers"
            :user-count.sync="praiseData.list.userCount"
            :gold-count.sync="praiseData.list.goldCount"
            :typeid.sync="tid"
            :fid.sync="fid"
            :tips.sync="praiseData.tips"
            v-if="!isEmpty(praiseData)">
         </praise>
    </section>

     <!--亮回复-->
     <artical-comment
      title="这些回复亮了"
      title-fixed
      v-if="light && light.length && page == 1"
      :page.sync="page"
      :tid.sync="tid"
      :fid.sync="fid"
      :data.sync="light"
      :is-admin.sync="isAdmin"
      :has-praise="hasPraise"
      :unlights-enable="unlightsEnable"
      :author-puid.sync="author_puid"
      :ft.sync="fontSize"
      @toast="toast">
     </artical-comment>

     <!--广告位-->
     <card-ad
        dace="bbs_detailsAd"
        v-if="!isEmpty(bottom_ad)"
        :url.sync="bottom_ad.url"
        :pic.sync="bottom_ad.img"
        :title.sync="bottom_ad.title">
     </card-ad>

     <!--全部回复-->
     <artical-comment
      title="全部回复"
      v-if="!isLoading && !isError"
      is-posts
      :post-count.sync="postCount"
      :show-last.sync="gotoPostLast"
      :is-owner.sync="isOwner"
      :page.sync="page"
      :total-page.sync="totalPage"
      :last-post-count.sync="lastPostCount"
      :last-pid.sync="lastPid"
      :tid.sync="tid"
      :fid.sync="fid"
      :pid.sync="pid"
      :data.sync="posts"
      :is-loading="isReplyLoading"
      :is-admin.sync="isAdmin"
      :has-praise="hasPraise"
      :unlights-enable="unlightsEnable"
      :author-puid.sync="author_puid"
      :ft.sync="fontSize"
      @getpost="getPost"
      @toast="toast">
     </artical-comment>

     <toast :show.sync="showToast" width="16em" :time="2000" type="text">{{toastMsg}}</toast>
</section>
</template>

<script>
import _ from 'underscore'
import $ from 'common/zepto'
import dace from 'common/dace'
import * as BBSModel from '../common/models'
import { getInfo, setTitle, isIOS, checkLogin, sendHideLoading } from 'common/app'
import { getFontSize, replaceNode } from 'common/utils'
import { golbal } from 'common/events'
import vote from 'common/vote'
import drop from 'common/drop'
import * as image from 'common/image'
import * as bridge from 'common/bridge'
import * as user from 'common/user'

import { Loading, Toast, Praise, CardAd } from 'components'
import { articalComment } from '../components'

export default {
    components: {
      articalComment,
      Loading,
      Praise,
      Toast,
      CardAd
    },
    data(){
        return {
            merge_title:"",
            forum: {},
            surprise: [],
            title: "",
            time: "",
            tid : "",
            fid : "",
            pid : "",
            content: "",
            userImg: "",
            username: "",
            author_puid: "0",
            toastMsg: "",
            certurl: "",
            certtype: 0,
            certinfo : "",
            contentHeight: 0,
            postCount: 0,
            hits: 1,
            night: 0,
            nopic: 0,
            page: 1,
            totalPage: 1,
            lastPostCount: 0,
            fontSize: getFontSize(),
            isOwner: false,
            isNew: false,
            gotoPostLast: false,
            isAdmin: false,
            isError: false,
            isLoading: true,
            isReplyLoading: true,
            is_recommend_filter: false,
            showToast: false,
            hasPraise: false,
            isError: false,
            errorText: "抱歉！暂无权限浏览帖子，去别处逛逛吧",
            unlightsEnable: false,
            lastPid: "",
            light: [],
            posts : [],
            author: {},
            praiseData: {},
            bottom_ad: {}
        }
    },
    ready() {
        this.night = getInfo().night
        this.nopic = getInfo().nopic


        golbal.on("updateFontsize", (fontSize) => {
            this.fontSize = fontSize
        })

        golbal.on("updateNightMode", (night) => {
            this.$els.content.querySelectorAll("img").forEach(item => {
                  let nSrc = image.replaceImageWithMode(item.src, night)
                  if(item.src != nSrc){
                      item.src = nSrc
                  }
            });
        })

        //注册事件，等Native调起, for android.
        bridge.register("hupu.ui.bbspageupdate", () =>{
            this.updatePage()
        });

        //最后一页回复，刷新页面
        bridge.register("hupu.ui.refresh", () => {
            this.getPost(this.totalPage, () => {
                this.isNew = true
            })
        });

        //返回页面最顶部
        bridge.register("hupu.ui.backtop", function(){
            window.scrollTo(0, 0)
        });

        //hash变化时，页面reload
        $(window).on("hashchange", () => {
            location.reload()
        });
    },
    methods: {
        isEmpty: _.isEmpty,
        filterSmile: image.filterSmile,
        /**
         * 设置页面最小高度
         */
        updateBodyHeight(){
            //页面大于两张load图，即不设置body高度
            if(this.getLazyImages().size() > 2) return

            let docH = $(document).height();
            let winH = $(window).height();
            if(docH < winH){
                $("body").css("height", winH);
            } else{
                //尝试修复页面高度引起的底部留白问题.
                if(isIOS){
                    $("body").css("height", docH);
                }
                this.$nextTick(() => {
                    $("body").css("height","");
                })
            }
        },
        toast(msg){
            this.$emit('toast', msg)
        },
        updatePage(){
            bridge.send("hupu.ui.updatebbspager", {
                page:  this.page,
                total: this.totalPage
            });
        },
        getArticle(){
            let params = {
                tid  : this.tid,
                fid  : this.fid,
                nopic: getInfo().nopic,
                night: getInfo().night,
                page : 1,
                nps  : this.nps
            }
            if(this.isOwner){
                params.postAuthorPuid = this.ownerUid
            }
            BBSModel.getBBSArticle
                    .bind(params)
                    .execute(({data}) => {
                        this.isLoading = false

                        this.isError = !!data.error
                        //报错
                        if(this.isError){
                            this.errorText = data.error.text
                        } else{
                            this.title = data.title
                            this.totalPage = data.totalPage || 1

                            //合并帖子拉取新回复
                            if(data.tid){
                                this.tid = data.tid
                            }

                            //设置页面标题
                            setTitle(this.title)

                            //最新评论，跳转到最后一页
                            if(this.isNew){
                                this.page = this.totalPage
                            }

                            this.certurl = data.certurl
                            if(!_.isEmpty(data.certuser)){
                                let cert = user.getUserCert(data.certuser)
                                this.certtype = cert.type
                                this.certimage = cert.image
                                this.certinfo = cert.info
                            }
                            if(!_.isUndefined(data.hits)) this.hits = data.hits

                            this.postCount = parseInt(data.replies)
                            this.merge_title = data.merge_title
                            this.time = data.time
                            this.content = data.content
                            this.author_puid = data.author_puid
                            this.isAdmin = !!parseInt(data.is_admin)
                            this.forum = data.forum
                            this.fid = data.fid
                            this.userImg = data.userImg
                            this.username = data.username
                            this.surprise = data.surprise || []
                            this.bottom_ad = data.bottom_ad
                            this.hasPraise = !!parseInt(data.show_post_praise)
                            this.unlightsEnable = !!parseInt(data.forum.unlights_enable)
                            this.is_recommend_filter = !!parseInt(data.is_recommend_filter)

                            //通知客户端更新页码
                            this.updatePage()

                            //赞赏
                            if(!_.isEmpty(data.praise) && data.praise.status == 200){
                                if(!_.isEmpty(data.praise.list.goldCount)){
                                    data.praise.list.goldCount = parseInt(data.praise.list.goldCount)
                                }
                                if(!_.isEmpty(data.praise.list.userCount)){
                                    data.praise.list.userCount = parseInt(data.praise.list.userCount)
                                }
                                this.praiseData = data.praise
                                this.author = data.praise.userinfo
                            }

                            //绑定事件
                            this.$nextTick(()=>{
                                this.bindEvent()

                                //更多回复
                                let getPost = () => {
                                  if(this.postCount){
                                    this.getPost(this.page)
                                  }
                                }
                                //亮评论, 点击查看楼主，不显示亮评
                                if(!this.isOwner && this.page == 1){
                                  this.getLight( getPost )
                                }else{
                                  getPost()
                                }
                            })

                        }

                        //通知NA隐藏Loading
                        sendHideLoading()

                    }, ()=>{
                        this.isLoading = false
                        this.isError = true

                        //通知NA隐藏Loading
                        sendHideLoading()
                    })
        },
        bindEvent(){
            let self = this
            let na = getInfo()
            //展示投票
            $(this.$els.content).find("span._vote").each(function(idx, elem){
               vote({
                   type:'news',
                   elem: elem,
                   typeid: self.tid,
                   getVote: BBSModel.getBBSVote,
                   saveVote: BBSModel.saveBBSVote,
                   scope: self
               })
            });

            //论坛彩蛋
            if(this.surprise && this.surprise.length){
                let rand = (this.surprise.length * Math.random())|0;
                let surpriseImg = this.surprise[rand];
                drop.create(surpriseImg, 80);
                setTimeout(function(){
                    drop.remove();
                }, 5000);
            }

            //图片懒加载
            $(window).on("touchmove scroll", () => {
                if(!na.nopic) {
                  self.lazyLoadInterval = setTimeout(() => {
                      clearTimeout(self.lazyLoadInterval);
                      this.startLazyLoad()
                  }, 200)
                }
            });


            /**
             * 版务操作
             * 0 取消， 1为撤下推荐，-1为推荐
             */
            $(this.$els.header).find(".J-bbsrecommend-manage").on("change", function(e){
                let $select = $(this);
                let type = +($select.val()) || 0;
                switch(type){
                    case 1:
                        self.changeRecommendStatus(1, function(){
                            self.is_recommend_filter = true
                            $select.val(0);
                        }, function(){
                            $select.val(0);
                        });
                        break;
                    case -1:
                        self.changeRecommendStatus(-1, function(){
                            self.is_recommend_filter = false
                            $select.val(0);
                        }, function(){
                            $select.val(0);
                        });
                        break;
                }
            });

            //正文区域
            let contentContainer = $(this.$els.content)
            image.renderGifs(contentContainer, "bbs");
            //图片点击事件
            contentContainer.find("img").not(".emoji").on("click", function(e){
                var currentTarget = e.currentTarget;
                //点击gif图的时候计算图片大小，防止gif角标错位
                if(currentTarget.getAttribute("data-gif") && currentTarget.getAttribute("data-src")) {
                    var realSrc = currentTarget.getAttribute("data-src");
                    $(currentTarget).on("load", function() {
                      image.imgResize(currentTarget, "content");
                    });
                    currentTarget.src = realSrc;

                }
                if(currentTarget.getAttribute("data-src")){
                    var realSrc = currentTarget.getAttribute("data-src");
                    currentTarget.src = realSrc;
                    currentTarget.removeAttribute("data-src");
                    return false;
                } else{
                    if(!currentTarget.getAttribute("data-gif")){
                        var imgs = contentContainer.find("img");
                        image.handleCreateAlbum(currentTarget, imgs);
                    } else{
                        image.handlerClickGif(currentTarget, na.nopic);
                    }
                }
            });
        },
        changeRecommendStatus(status, callback, errCallback){
            let loginEvent = () => {
                BBSModel
                    .changeRecommendStatus
                    .bind({
                        tid: this.tid,
                        status: status
                    })
                    .execute(({data})=>{
                        let msg = "";
                        if(data.status == 200){
                            msg = status === 1 ? "隐藏推荐成功":"取消隐藏推荐成功";
                            this.toast(msg);
                            callback && callback();
                        } else{
                            msg = data.error ? data.error.text : "";
                            this.toast(msg);
                            errCallback && errCallback();
                        }
                    })
            }
            checkLogin(loginEvent)
        },
        getLazyImages(){
            return $("body").find(".lazy")
        },
        getLight( callback ){
            let params = {
                tid: this.tid,
                fid: this.fid,
                nopic: getInfo().nopic,
                night: getInfo().night
            }
            BBSModel.getBBSLight
                    .bind(params)
                    .execute(({data}) => {
                        this.light = this.addPostsFold(data.list)

                        callback && callback()
                    }, ()=>{
                        callback && callback()
                    })
        },
        getPost( page, callback ){
            let params = {
                page,
                tid: this.tid,
                fid: this.fid,
                nopic: getInfo().nopic,
                night: getInfo().night
            }
            if(this.isOwner){
                params.postAuthorPuid = this.ownerUid
            }
            BBSModel.getBBSPost
                    .bind(params)
                    .execute(({data}) => {
                        this.posts = this.addPostsFold(data.result.list)
                        //最后一页的长度
                        if(this.page == this.totalPage && data.result.list){
                            let list = data.result.list;
                            let lastPost = list.length > 0 ? list[list.length - 1] : null;
                            this.lastPid = lastPost && lastPost.pid ? lastPost.pid : null;
                            this.lastPostCount = data.result.list.length
                        }

                        this.isReplyLoading = false

                        //有图模式，延迟执行
                        if(!getInfo().nopic){
                            setTimeout(()=>{
                                this.startLazyLoad()
                            }, 500)
                        }
                        callback && callback()

                        //页面高度不够，补足
                        setTimeout(()=>{
                            this.updateBodyHeight()
                        }, 600)
                    }, ()=>{
                      this.isReplyLoading = false
                    })
        },
        addPostsFold( list ){
            if(_.isArray(list)){
                list.map(item =>{
                    item.qoute_isFold = false
                    item.isFold = false

                    if(item.certurl && !_.isEmpty(item.certuser)){
                        let cert = user.getUserCert(item.certuser)
                        item.cert = cert
                    }
                })
            }
            return list
        },
        startLazyLoad(){
            let lazyImgs = this.getLazyImages()
            this.lazyload(lazyImgs);
        },
        lazyload(pics) {
            if(!pics.size()) return

            let self = this;
            let winHeight = $(window).height();
            let scrollTop = $(window).scrollTop();

            pics.each(function(idx, img){
                let $img = $(img);
                let lazyTop = $img.offset().top;
                if(img.getAttribute("data-src")){
                    //如果设置了css style，img上多一个style属性，不重新计算css style
                    if(!img.getAttribute('style')){
                        image.imgResize(img)
                    }

                    if (lazyTop < (scrollTop + (2 * winHeight))) {
                        $img.attr("src", $img.attr("data-src"));
                        $img.removeAttr("data-src");
                        $img.removeClass("lazy")
                    }
                }
            })
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
            this.fontSize = getFontSize(this.$route.query.ft)
            this.isOwner = !!parseInt(this.$route.query.postAuthorPuid)
            this.ownerUid = parseInt(this.$route.query.postAuthorPuid)
            this.tid   = this.$route.query.tid
            this.fid   = this.$route.query.fid
            this.page  = +this.$route.query.page || 1
            this.pid   = this.$route.query.pid || ""
            this.hits  = this.$route.query.hits || 1
            this.nps   = this.$route.query.nps || -999

            this.isNew = !_.isUndefined(this.$route.query.isnew)
            let isPrev = !_.isUndefined(this.$route.query.prev) && parseInt(this.$route.query.prev) === 1
            this.gotoPostLast = this.isNew || isPrev
            this.getArticle()

            //帖子浏览数统计
            image.getmock("http://msa.hupu.com/thread_hit?tid=" + this.tid)
        }
    }
}
</script>

<style lang="less">
@import "../styles/detail.less";
</style>
