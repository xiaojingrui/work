<template>
<section class="detail-wrap">
    <loading :show="isLoading" text="" position="absolute"></loading>
    <artical-title :news.sync="news"></artical-title>
    <artical-comment
       page="comment"
       title="最新评论"
       :isadmin.sync="isadmin"
       :leaguesen.sync="leaguesen"
       :username.sync="username"
       :data.sync="data"
       :uid.sync="uid"
       :cid.sync="cid"
       @toast="toast"
       v-if="data.length">
   </artical-comment>

   <toast :show.sync="showToast" :time="2000" type="text">{{toastMsg}}</toast>
</section>
</template>

<script>
import { getNewsComment } from '../common/models'
import { getInfo, setTitle } from 'common/app'

import {
    articalTitle,
    articalComment
} from '../components'
import { Loading, Toast } from 'components'


export default {
    components: {
        Loading,
        Toast,
        articalTitle,
        articalComment
    },
    data(){
        return {
            isLoading: true,
            news: {},
            isadmin: false,
            nid : "",
            top_ncid: "",
            leaguesen: "",
            time_zone: "",
            username: "",
            top_comment: [],
            data: [],
            showToast: false,
            toastMsg: ""
        }
    },
    ready() {
        
    },
    methods: {
        getAllReply(){
            getNewsComment
                .bind({
                    nid: this.nid,
                    time_zone: this.time_zone,
                    top_ncid: this.top_ncid
                })
                .execute(({data})=>{
                    this.isLoading = false
                    setTitle(data.news.title)

                    this.news = data.news
                    this.uid = data.uid
                    this.cid = data.cid
                    this.isadmin = !!data.is_admin
                    this.top_comment = data.top_comment || []
                    this.data = data.data || []
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
            this.nid = this.$route.query.nid
            this.leaguesen = this.$route.query.leaguesEn || ""
            this.time_zone = this.$route.query.time_zone || "Asia/Shanghai"
            this.top_ncid  = this.$route.query.top_ncid  || ""

            this.getAllReply()
        }
    }
}
</script>

<style lang="less"></style>
