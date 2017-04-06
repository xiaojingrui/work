<template>
	<section class="standings-rank">
		<div class="main">
		<scroller lock-x scrollbar-y>

		<div v-if='leaguename == "chlg" || leaguename == "eurocup" || leaguename == "amerciacup" || leaguename == "uefael"'>
			<div v-if="!isEmpty(against)">
				<soccer-vs
					v-if="leaguename =='chlg'"
					:leaguename.sync="leaguename"
					:datas.sync="against">
				</soccer-vs>
				<common-vs
					v-else
					:leaguename.sync="leaguename"
					:datas.sync="against">
				</common-vs>
			</div>

	        <div v-for="(key,item) in rank[0].ranks_data" v-if="isInGroups(key)">
				<table class="mod-title title">
					<thead>
						<tr>
							<td width="10%" class="type">{{getGroup(key)}}组</td>
							<td width="35%" colspan="2" align="left">球队</td>
							<td width="10%" align="center">场次</td>
							<td width="7%" align="center">胜</td>
							<td width="7%" align="center">平</td>
							<td width="7%" align="center">负</td>
							<td width="14%" align="center">进/失</td>
							<td width="10%" align="center">积分</td>
						</tr>
					</thead>
				</table>
				<table class="mod-table">
					<tbody>
						<tr class="link tap" v-for="(subIndex, subItem) in item" @click="goto(subItem.tid)">
							<td width="10%">
								<span class="num" :class="{'red-border': subItem.rank <= 2 || (subItem.rank == 3 && leaguename == 'eurocup'),
	                                'yellow-border': subItem.rank == 3 && leaguename == 'chlg'}">{{subItem.rank}}</span>
							</td>
							<td width="10%" align="left">
								<span class="td-wrap">
	                                <span class="logo">
	                                 <img :src="getSrc(subItem.logo, subItem.tid)" width="28" />
	                               </span>
	                            </span>
							</td>
							<td width="25%" align="left">
								<span class="name">{{subItem.name}}</span></span>
							</td>
							<td width="10%" align="center">{{subItem.mp}}</td>
							<td width="7%" align="center">{{subItem.won}}</td>
							<td width="7%" align="center">{{subItem.draw}}</td>
							<td width="7%" align="center">{{subItem.lose}}</td>
							<td width="14%" align="center">{{subItem.gf}}/{{subItem.ga}}</td>
							<td width="10%" align="center">{{subItem.pts}}</td>
						</tr>
					</tbody>
				</table>
	        </div>
			<p class="notice">比赛进行中，您将看到依据各支球队实时进球调整的动态排名，这可能与比赛结束后的积分榜排序稍有不同。</p>
		</div>

		<div v-if="leaguename == 'afccl'">
			<soccer-vs v-if="!isEmpty(against)" :leaguename.sync="leaguename" :datas.sync="against"></soccer-vs>

			<div v-for="(key,item) in rank[0].ranks_data"  v-if="isInGroups(key)">
			   <table class="mod-title title">
				   <thead>
					   <tr>
						   <td width="10%" class="type">{{getGroup(key)}}组</td>
							<td width="35%" colspan="2" align="left">球队</td>
						   <td width="10%" align="center">场次</td>
						   <td width="7%" align="center">胜</td>
						   <td width="7%" align="center">平</td>
						   <td width="7%" align="center">负</td>
						   <td width="14%" align="center">进/失</td>
						   <td width="10%" align="center">积分</td>
					   </tr>
				   </thead>
			   </table>
			   <table class="mod-table">
				   <tbody>
					   <tr class="link tap" v-for="(subIndex, subItem) in item" @click="goto(subItem.tid)">
						   <td width="10%">
								<span class="num" :class="{'red-border red': subItem.ranking <= 2}">{{subItem.ranking}}</span>
						   </td>
						   <td width="10%" align="left">
							   <span class="td-wrap">
								  <span class="logo">
									<img :src="getSrc(subItem.team_logo, subItem.tid)" width="28" />
								  </span>
								</span>
						   </td>
						   <td width="25%" align="left">
							   <span class="name">{{subItem.team_name}}</span></span>
						   </td>
						   <td width="10%" align="center">{{subItem.played}}</td>
						   <td width="7%" align="center">{{subItem.wins}}</td>
						   <td width="7%" align="center">{{subItem.ties}}</td>
						   <td width="7%" align="center">{{subItem.losses}}</td>
						   <td width="14%" align="center">{{subItem.goalsFor_goalsAgainst}}</td>
						   <td width="10%" align="center">{{subItem.points}}</td>
					   </tr>
				   </tbody>
			   </table>
		    </div>
		</div>

		<div v-if='leaguename != "chlg" && leaguename != "eurocup" && leaguename != "amerciacup" && leaguename != "uefael" && leaguename != "afccl"'>
			<table class="mod-title">
			   <thead>
				   <tr>
					   <td width="10%" class="type">排名</td>
					   <td width="35%" colspan="2" align="left">球队</td>
					   <td width="10%" align="center">场次</td>
					   <td width="7%" align="center">胜</td>
					   <td width="7%" align="center">平</td>
					   <td width="7%" align="center">负</td>
					   <td width="14%" align="center">进/失</td>
					   <td width="10%" align="center">积分</td>
				   </tr>
			   </thead>
		   </table>
		   <table class="mod-table">
			   <tbody v-if="rank[0].ranks_data.length">
				   <tr v-for="(index, item) in rank[0].ranks_data" class="link tap" @click="goto(item.team_id)">
					   <td width="10%">
						   <!-- 意甲 123 45 181920 -->
						   <span class="num" v-if="leaguename == 'seri'" :class="{red: item.ranking <= 3, yellow: item.ranking == 4 || item.ranking == 5, green: item.ranking >= rank[0].ranks_data.length - 2}">{{item.ranking}}</span>
						   <!-- 法甲 123 4 181920 -->
						   <span class="num" v-if="leaguename == 'fran'" :class="{red: item.ranking <= 3, yellow: item.ranking == 4, green: item.ranking >= rank[0].ranks_data.length - 2}">{{item.ranking}}</span>
						   <!-- 西甲 德甲 英超 1234 56 181920（其中德甲161718） -->
						   <span class="num"
						   v-if="leaguename == 'liga' || leaguename == 'bund' || leaguename == 'epl' || leaguename == 'fifa'"
						   :class="{red: item.ranking <= 4,
							   yellow: (item.ranking == 5 || item.ranking == 6),
							   green: (item.ranking >= rank[0].ranks_data.length - 2) }">{{item.ranking}}</span>
						   <!-- 中超 1234 1516 -->
						   <span class="num" v-if="leaguename == 'csl'" :class="{red: item.ranking <= 4, green: item.ranking >= rank[0].ranks_data.length - 1}">{{item.ranking}}</span>
						   <!-- 中甲 12 1516 -->
						   <span class="num" v-if="leaguename == 'csl_zj'" :class="{red: item.ranking <= 2, green: item.ranking >= rank[0].ranks_data.length - 1}">{{item.ranking}}</span>
						   <span class="num" v-if="leaguename != 'csl'
						   		&& leaguename != 'csl_zj'
								&& leaguename != 'liga'
								&& leaguename != 'bund'
								&& leaguename != 'epl'
								&& leaguename != 'fifa'
								&& leaguename != 'seri'
								&& leaguename != 'fran'">{{item.ranking}}</span>
					   </td>
					   <td width="10%" align="left">
						   <span class="td-wrap">
							   <span class="logo">
								   <img :src="item.team_logo" width="28" />
							   </span>
						   </span>
					   </td>
					   <td width="25%" align="left">
						   <span class="name">{{item.team_name}}</span></span>
					   </td>
					   <td width="10%" align="center">{{item.played}}</td>
					   <td width="7%" align="center">{{item.wins}}</td>
					   <td width="7%" align="center">{{item.ties}}</td>
					   <td width="7%" align="center">{{item.losses}}</td>
					   <td width="14%" align="center">{{item.goalsFor_goalsAgainst}}</td>
					   <td width="10%" align="center">{{item.points}}</td>
				   </tr>
			   </tbody>
		   </table>
		   <p class="notice" v-if="leaguename != 'csl_zj'">比赛进行中，您将看到依据各支球队实时进球调整的动态排名，这可能与比赛结束后的积分榜排序稍有不同。</p>
		</div>

		</scroller>
		</div>
	</section>
</template>

<script>
import CommonVs from './common_vs'
import SoccerVs from './soccer_vs'
import { Scroller } from 'components'
import { go } from 'common/router'
import _ from 'underscore'

export default {
	components:{
		CommonVs,
		SoccerVs,
		Scroller
	},
    props: {
		against: Object,
        rank: Array,
        leaguename: String
    },
	methods: {
		isEmpty: _.isEmpty,
		goto(tid){
			go(`kanqiu://soccerleagues/${this.leaguename}/team/${tid}`)
		},
		getSrc(logo, tid){
			return logo || `http://b10.hoopchina.com.cn/games/teams/chlg/8_${tid}.png`
		},
		isInGroups(index){
			return ~[0,1,2,3,4,5,6,7,8,9,10,11,'A','B','C','D','E','F','G','H','I','J','K','L'].indexOf(index)
		},
		getGroup(key){
			let groups = ['A','B','C','D','E','F','G','H','I','J','K','L']
			if(~groups.indexOf(key)){
				return key
			} else{
				return groups[key]
			}
		}
	}
}
</script>

<style lang="less">
.standings-rank{
	.notice{
		padding: 10px;
		color: #a9a9b2;
		font-size: 12px;
		background-color: #efebec;
	}
	.mod-table {
    	tbody {
    		tr {
				line-height: 32px;
			}
		}
	}
}
.night{
	.standings-rank{
		.notice{
		    background-color: #1f1f1f;
		    color: #959595;
		}
   }
}
</style>
