<template>
    <section class="all-rank">
        <table class="mod-title">
            <thead>
                <tr>
                    <td width="60%" colspan="3">{{chinese}}排行榜</td>
                    <td width="20%" align="center">球队</td>
                    <td width="20%" align="center">数据</td>
                </tr>
            </thead>
        </table>
        <section v-if="data.length">
            <scroller lock-x scrollbar-y use-pullup :pullup-config="pullupConfig" @pullup:loading="load">
            <table class="mod-table">
                <tbody>
                    <tr v-for="item in data" @click="goto(item)">
                        <td width="8%">
                            <span class="num" :class="{red: item.rank == 1}">{{item.rank}}</span>
                        </td>
                        <td width="12%">
                            <span class="logo">
                                <img :src="item.player_header" width="30" height="34" />
                                <span class="mask"></span>
                            </span>
                        </td>
                        <td width="40%">
                            <span class="detail">
                                <span class="name">{{item.player_name}}</span>
                                <span class="others">
                                    {{item.pts}}分
                                    {{item.reb}}板
                                    {{item.asts}}助
                                </span>
                            </span>
                        </td>
                        <td width="20%" align="center">{{item.team_name}}</td>
                        <td width="20%" align="center">{{item.val}}</td>
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
            go(`kanqiu://nba/nba/player/${data.player_id}`)
        },
        getPageData(type, category, page, uuid){
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

          this.getPageData(this.type, this.category, this.page);
      }
    }
}
</script>

<style lang="less" scoped>
@import '../styles/theme.less';
@import '../styles/all_rank.less';

.detail {
    span {
        display: block;
    }

    .others {
        color: @morning_gray2_cor;
        font-size: 11px;
    }
}

body.night {
    .detail {
        .others {
            color: @night_gray2_cor;
        }
    }
}
</style>
