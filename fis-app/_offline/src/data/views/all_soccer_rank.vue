<template>
<section class="all-rank">
    <table class="mod-title">
        <thead>
            <tr>
                <td width="50%" colspan="3">{{name}}</td>
                <td width="30%" align="center" v-if='isPlayerData'>球队</td>
                <td width="20%" align="center">{{title}}</td>
            </tr>
        </thead>
    </table>
    <section v-if="data.length">
        <scroller lock-x scrollbar-y use-pullup :pullup-config="pullupConfig" @pullup:loading="load">
        <table class="mod-table">
            <tbody>
                <tr v-for="(index, item) in data" @click="goto(item)">
                    <td width="8%">
                        <span class="num" :class="{red: index === 0}">{{index+1}}</span>
                    </td>
                    <td width="12%">
                        <span :class="{'logo':isPlayerData, 'team_logo':!isPlayerData}">
                            <img :src="isPlayerData ? item.player_logo : item.team_logo" width="30" />
                            <span class="mask"></span>
                        </span>
                    </td>
                    <td width="30%">{{isPlayerData ? item.player_name : item.team_name}}</td>
                    <td width="30%" align="center" v-if="isPlayerData">{{item.team_name}}</td>
                    <td width="20%" align="center" v-if="isPlayerData">
                        {{teamName(item)}}
                    </td>
                    <td width="20%" align="center" v-else>
                        {{ rank_type == 'pass_per'? (item[field]* 100 + '%') : item[field] }}
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
import { getAllSoccerRank } from '../common/models'
import { getInfo } from 'common/app'

export default {
    components:{
        Scroller
    },
    data(){
        return {
            name: '',
            title: '',
            rank_type: '',
            field: '',
            league_name: '',
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
            let league_name = this.league_name
            let rank_type = this.rank_type
            if(league_name != "afccl") return;

            if(this.isPlayerData){
                go(`kanqiu://soccerleagues/${league_name}/player/${data.player_pid}`)
            }else{
                go(`kanqiu://soccerleagues/${league_name}/team/${data.team_id}`)
            }
        },
        teamName(data){
            let league_name = this.league_name
            let rank_type = this.rank_type
            let field = this.field

            if (rank_type == "pass_per_p"){
                return `${data[rank_type]*100}%`
            }else{
                if (league_name == "afccl" || league_name == "chlg" || league_name == "uefael"){
                    return data[field]
                }else{
                    return data[rank_type]
                }
            }
        },
        getPageData(rank_type, league_name, page, uuid){
            getAllSoccerRank.bind({rank_type, page, league_name}).execute(({data}) => {
                if(data.data.length){
                    this.name = data.name
                    this.title = data.title
                    this.field = data.field
                    this.data = this.data.concat(data.data)

                    uuid &&　this.$broadcast('pullup:reset', uuid)
                } else{
                    uuid &&　this.$broadcast('pullup:done', uuid)
                }
            })
        },
        load(uuid){
            this.page++
            this.getPageData(this.rank_type, this.league_name, this.page, uuid);
        }
    },
    computed:{
        isPlayerData(){
            return this.rank_type == "goals" || this.rank_type == "assits" || this.rank_type.substr(-2) === "_p"
        }
    },
    route: {
      data ({to, next}) {
          this.rank_type = this.$route.query.rank_type
          this.page = this.$route.query.page || 1
          this.league_name = this.$route.query.league_name

          this.getPageData(this.rank_type, this.league_name, this.page)
      }
    }
}
</script>

<style lang="less" scoped>
@import '../styles/theme.less';
@import '../styles/all_rank.less';
</style>
