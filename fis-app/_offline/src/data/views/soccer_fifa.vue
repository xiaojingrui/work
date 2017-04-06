<template>
    <section class="fifa soccer mod-rank-wrap">
        <!-- <loading :show="isLoading" text="" position="absolute"></loading> -->
        <section class="data-tab" v-if="!isLoading">
            <ul>
                <li class="tab-world" @click="tab = 'world'" :class="{ active: tab =='world'}">FIFA排名</li>
                <li class="tab-asia" @click="tab = 'asia'" :class="{ active: tab =='asia'}">亚洲排名</li>
            </ul>
        </section>
        <section class="swiper-container" v-if="!isLoading">
            <section class="world" v-if="tab =='world'">
                <scroller lock-x>
            	<div class="main">
            		<div v-if="world.length">
            			<table class="mod-title title">
            				<thead>
            					<td width="10%" align="center">排名</td>
                                <td width="6%" align="center">&nbsp;</td>
            					<td width="64%" colspan="2" align="left">球队</td>
            					<td width="20%" align="center">本月积分</td>
            				</thead>
            			</table>
            			<table class="mod-table">
            				<tbody>
            					<tr v-for="item in world" class="tap link" :class="{'tr-china': item.name_zh == '中国'}" @click="goto(item.team_id)">
            	    				<td width="10%" align="center">
            	                        <span class="num">{{item.rank}}</span>
            	                    </td>
                                    <td width="6%" align="center">
                                        {{{createRank(item)}}}
                                    </td>
            	                    <td width="10%" align="left">
            	    					<span class="logo">
                                            <img :src="item.team_logo" width="28" />
                                        </span>
            	                    </td>
            	                    <td width="54%" align="left">{{item.name_zh}}</td>
                                    <td width="20%" align="center">{{item.points}}</td>
            	    			</tr>
            				</tbody>
            			</table>
            		</div>
            		<div class="no-data" v-else>暂无数据</div>
            	</div>
                </scroller>
            </section>
            <section class="asia" v-if="tab == 'asia'">
                <scroller lock-x>
            	<div class="main">
                    <div v-if="asia.length">
            			<table class="mod-title title">
            				<thead>
            					<td width="10%" align="center">排名</td>
                                <td width="6%" align="center">&nbsp;</td>
            					<td width="54%" colspan="2" align="left">球队</td>
                                <td width="15%" align="center">亚洲</td>
            					<td width="15%" align="center">本月积分</td>
            				</thead>
            			</table>
            			<table class="mod-table">
            				<tbody>
            					<tr v-for="item in asia" class="tap link" :class="{'tr-china': item.name_zh == '中国'}" @click="goto(item.team_id)">
            	    				<td width="10%" align="center">
            	                        <span class="num">{{item.rank}}</span>
            	                    </td>
                                    <td width="6%" align="center">
                                        {{{createRank(item)}}}
                                    </td>
            	                    <td width="10%" align="left">
            	    					<span class="logo"><img width="28" v-bind:src="item.team_logo" /></span>
            	                    </td>
            	                    <td width="44%" align="left">{{item.name_zh}}</td>
                                    <td width="15%" align="center">{{item.afc_rank}}</td>
                                    <td width="15%" align="center">{{item.points}}</td>
            	    			</tr>
            				</tbody>
            			</table>
            		</div>
            		<div v-if="!asia.length" class="no-data">暂无数据</div>
            	</div>
                </scroller>
            </section>

        </section>
    </section>
</template>

<script>
import { getSoccernational } from '../common/models'
import { Loading } from 'components'
import { Scroller } from 'components'
import { go } from 'common/router'
import { getInfo, sendHideLoading } from 'common/app'

export default {
    components: {
        Loading,
        Scroller
    },
    ready(){
        getSoccernational.execute(({data}) => {
            this.world = data.world
            this.asia = data.aisa
            this.leaguename = data.league_name
            this.leaguechinese = data.league_chinese
            this.isLoading = false
            sendHideLoading()
        })
    },
    data () {
      return {
        leaguename: "",
        leaguechinese: "",
        tab: "world",
        world: [],
        asia: [],
        isLoading: true
      }
    },
    methods : {
        goto(tid){
            if(tid){
                go(`kanqiu://soccerleagues/${this.leaguename}/team/${tid}`)
            }
        },
        createRank(item){
            if(item.rank == item.previous_rank){
             return '<span class="state-stable">-</span>'
            } else if(item.rank < item.previous_rank){
             return '<span class="state-up"><i><small>'+ (item.previous_rank - item.rank) + '</small></i></span>'
            }else if (item.rank > item.previous_rank){
              return '<span class="state-down"><i><small>'+ (item.rank - item.previous_rank)  +'</small></i></span>'
            }
        }
    },
    route: {
      data ({to, next}) {

      }
    }
}
</script>

<style lang="less">
.state-stable {
    color: #a9a9b2
}

.state-up i {
    border-bottom: 6px solid #8dcf5d;
    border-left: 6px dashed transparent;
    border-right: 6px dashed transparent;
    top: -10px
}

.state-down i {
    border-top: 6px solid #ff3f4c;
    border-left: 6px dashed transparent;
    border-right: 6px dashed transparent;
    top: 10px
}

.state-up i,.state-down i {
    position: relative
}

.state-up small,.state-down small {
    position: absolute;
    left: -6.5px;
    width: 14px;
    font-size: 9px;
    font-style: normal;
    text-align: center
}

.state-up small {
    top: 22px;
    color: #8dcf5d
}

.state-down small {
    top: 2px;
    color: #ff3f4c
}

.tr-china {
    background-color: #eeebeb
}

body.night .state-stable {
    color: #5a5a5f
}

body.night .state-up i {
    border-bottom: 6px solid #557c38;
    border-left: 6px dashed transparent;
    border-right: 6px dashed transparent
}

body.night .state-down i {
    border-top: 6px solid #99262e;
    border-left: 6px dashed transparent;
    border-right: 6px dashed transparent
}

body.night .state-up small {
    color: #557c38
}

body.night .state-down small {
    color: #99262e
}

body.night .tr-china {
    background-color: #1f1f1f
}
</style>
