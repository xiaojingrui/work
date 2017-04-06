<template>
    <scroller lock-x>
    <section class="{{type}}-basketball basketball-wrap">

            <common-vs :datas.sync="against[index-1]" v-if="!isEmpty(against[index-1])" :leaguename.sync="leaguename"></common-vs>

            <div v-for="(findex, item) in rank[index].ranks_data" v-if="hasRanks(rank[index].ranks_data)">
            	<table class="mod-title" >
            		<thead>
            			<tr>
            				<td width="8%" align="center">{{findex}}组</td>
            				<td width="34%" colspan="2" align="left">球队</td>
            				<td width="10%" align="center">场次</td>
            				<td width="6%" align="center">胜</td>
            				<td width="6%" align="center">负</td>
                            <td width="13%" align="center">总得分</td>
                            <td width="13%" align="center">净胜分</td>
                            <td width="10%" align="center">积分</td>
            			</tr>
            		</thead>
            	</table>
            	<table class="mod-table">
            		<tbody>
            			<tr class="link tap" v-for="(subIndex,subItem) in item">
            				<td width="8%" align="center">
                                <span class="num" :class="{red: subIndex < 4}">{{subIndex + 1}}</span>
                            </td>
                            <td width="10%" align="left">
            					<span class="logo"><img width="28" v-bind:src="subItem.logo" /></span>
                            </td>
                            <td width="24%" align="left">{{subItem.name}}</td>
            				<td width="10%" align="center">{{subItem.mp}}</td>
            				<td width="6%" align="center">{{subItem.won}}</td>
            				<td width="6%" align="center">{{subItem.lose}}</td>
            				<td width="13%" align="center">{{subItem.tpts}}</td>
                            <td width="13%" align="center">{{subItem.npts}}</td>
                            <td width="10%" align="center">{{subItem.pts}}</td>
            			</tr>
            		</tbody>
            	</table>
            </div>
            <div class="no-data" v-if="!hasRanks(rank[index].ranks_data)">{{getSex()}}</div>
    </section>
    </scroller>
</template>

<script>
import commonVs from './common_vs'
import _ from 'underscore'
import { Scroller } from 'components'

export default {
    components:{
        commonVs,
        Scroller
    },
    props:{
        against: Array,
        leaguename: String,
        rank: Array,
        index: String,
        type: String
    },
    methods: {
        isEmpty: _.isEmpty,
        getSex(){
           return `暂无${this.type == 'men'?'男':'女'}篮数据`
        },
        hasRanks(ranks){
            const keys = ["A","B"]
            let has = false
            keys.forEach(key => {
                if(ranks[key]){
                    has = true
                }
            })
            return has
        }
    }
}
</script>
