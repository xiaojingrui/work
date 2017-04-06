<template>
    <section class="mod-all transfer-player">
        <table class="mod-title fixed">
            <thead>
                <tr>
                    <td width="15%" align="center">{{title}}</td>
                    <td width="40%" align="left" colspan="2">球员</td>
                    <td width="20%" align="center">转会至</td>
                    <td width="25%" align="center">转会费(欧元)</td>
                </tr>
            </thead>
        </table>
        <section class="scroll-wrapper" v-if="data.length">
            <table class="mod-table">
                <tbody id="J-all-rank">
                    <tr class="tap" v-for="(index, item) in data" @click="goto(item)">
                        <td width="15%" align="center">
                            <span :class="{top20: rank_type == 'TOP20'}">{{rank_type == 'TOP20' ? index: item.occur_time }}</span>
                        </td>
                        <td width="11%" align="left">
                            <span class="logo">
                                <img :src="item.photo" width="30" />
                                <span class="mask" v-if="night"></span>
                            </span>
                        </td>
                        <td width="29%" align="left">
                            <div class="player-name">{{item.name}}</div>
                            <div class="old-team">{{item.from_team_name}}(原)</div>
                        </td>
                        <td width="20%" align="center">{{item.to_team_name}}</td>
                        <td width="25%" align="center" :class="{'td-icon': item.memo}">{{item.fee}}
                            <i class="icon" v-if="item.memo" data-memo="{%$val.memo%}"></i>
                        </td>
                    </tr>
                </tbody>
            </table>
        </section>
        <div class="mod-no-result" v-else>暂无转会球员数据或数据出错</div>
    </section>
</template>

<script>
import { go } from 'common/router'
import { Scroller } from 'components'
import { getAllSoccerTransfer } from '../common/models'
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
            go(`kanqiu://soccerleagues/${league_name}/player/${data.player_id}`)
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
            getAllSoccerTransfer.bind({rank_type, page, league_name}).execute(({data}) => {
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
