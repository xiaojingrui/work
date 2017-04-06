<template>
    <section class="mod-all all-rank trade-info trade">
    <table class="mod-title fixed">
        <thead>
            <tr v-if="type == 'trade'">
                <td width="40%" class="type" colspan="2">{{chinese}}</td>
                <td width="30%" align="left" class="th3">送出</td>
                <td width="30%" align="left" class="th4">得到</td>
            </tr>
            <tr v-else>
                <td width="40%" class="type" colspan="2">{{chinese}}</td>
                <td width="30%" align="center">原球队</td>
                <td width="30%" align="center">{{type == 'free' ? '备注': '新球队'}}</td>
            </tr>
        </thead>
    </table>
    <section class="scroll-wrapper" v-else="data.length">
        <scroller lock-x scrollbar-y use-pullup :pullup-config="pullupConfig" @pullup:loading="load">
        <table class="mod-table">
            <tbody>
                <tr class="tap" v-for="item in data" @click="goto(item)" v-if="type == 'trade'">
                    <td>
                        <table class="data-table">
                            <tr>
                                <td width="15%" align="center" rowspan="2" valign="top">
                                    <span class="logo">
                                        <img :src="item.player_photo" />
                                        <span class="mask" v-if="night"></span>
                                    </span>
                                </td>
                                <td width="27%" class="td2">{{item.name}}</td>
                                <td width="30%" align="left" valign="top" class="td3">
                                    <div>{{item.cost}}</div>
                                </td>
                                <td width="30%" align="left" valign="top" class="td4">
                                    <div>{{item.earn}}</div>
                                </td>
                            </tr>
                            <tr v-if="item.team_name">
                                <td colspan="3" class="contract">{{item.team_name}}</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr class="tap" v-for="item in data" @click="goto(item)" v-else>
                    <td>
                        <table class="data-table">
                            <tr>
                                <td width="15%" align="center">
                                    <span class="logo">
                                        <img :src="item.photo" />
                                        <span class="mask" v-if="night">
                                    </span>
                                </td>
                                <td width="25%" class="td2">{{item.alias}}</td>
                                <td width="30%" align="center" class="td3">{{item.from_team_name}}</td>
                                <td width="30%" align="center" class="td4">
                                    {{type == 'free'? item.memo: item.to_team_name }}
                                </td>
                            </tr>
                            <tr v-if="type != 'free' && item.memo">
                                <td colspan="3" class="contract">{{item.memo}}</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        </scroller>
    </section>
    <div class="mod-no-result" v-else>暂无比赛数据</div>
</section>
</template>

<script>
import { go } from 'common/router'
import { Scroller } from 'components'
import { getAllNBARank } from '../common/models'
import { getInfo } from 'common/app'

export default {
    components: {
        Scroller
    },
    data(){
        return {
            type: '',
            chinese: '',
            category: '',
            rank_type: '',
            night: getInfo().night,
            data: [],
            page: 1,
            pullupConfig: {
             content: '上拉加载更多',
             downContent: '松开进行加载',
             upContent: '上拉加载更多',
             loadingContent: '加载中...'
            }
        }
    },
    methods :{
        goto(data){
            go(`kanqiu://nba/nba/player/${data.hupu_pid}`)
        },
        getPageData(type, category, page, rank_type, uuid){
            getAllNBARank.bind({type, page, category}).execute(({data}) => {
                if(data.data.length){
                    this.data = this.data.concat(data.data)
                    this.chinese = data.chinese

                    uuid &&　this.$broadcast('pullup:reset', uuid)
                } else{
                    uuid &&　this.$broadcast('pullup:done', uuid)
                }
            })
        },
        load(uuid){
            this.page++
            this.getPageData(this.type, this.category, this.page, uuid);
        }
    },
    route: {
      data ({to, next}) {
          this.type = this.$route.query.type
          this.page = this.$route.query.page
          this.category = this.$route.query.category
          this.rank_type = this.$route.query.rank_type

          this.getPageData(this.type, this.category, this.page, this.rank_type);
      }
    }
}
</script>

<style lang="less">
@import "../styles/nba_trade.less";
</style>
