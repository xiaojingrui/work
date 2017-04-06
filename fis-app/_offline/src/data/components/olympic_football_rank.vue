<template>
    <scroller lock-x>
    <section class="{{type}}-football football-wrap">
        <common-vs :datas.sync="against[index-1]" v-if="!isEmpty(against[index-1])" :leaguename.sync="leaguename"></common-vs>

        <div v-for="(group, item) in rank[index].ranks_data" v-if="hasRanks(rank[index].ranks_data)">
        	<table class="mod-title">
        		<thead>
        			<tr>
        				<td width="8%" align="center">
                            {{group}}组
                        </td>
        				<td width="34%" colspan="2" align="left">球队</td>
        				<td width="10%" align="center">场次</td>
        				<td width="7%" align="center">胜</td>
        				<td width="7%" align="center">平</td>
                        <td width="7%" align="center">负</td>
                        <td width="17%" align="center">进/失</td>
                        <td width="10%" align="center">积分</td>
        			</tr>
        		</thead>
        	</table>
        	<table class="mod-table">
        		<tbody>
        			<tr class="link tap" v-for="(subIndex,subItem) in item">
        				<td width="8%" align="center">
                            <span class="num" :class="{red: (type=='men' && subIndex < 2) || (type=='women' && subIndex<3)}">{{subIndex + 1}}</span>
                        </td>
                        <td width="10%" align="left">
        					<span class="logo"><img width="28" v-bind:src="subItem.logo" /></span>
                        </td>
                        <td width="24%" align="left">{{subItem.name}}</td>
        				<td width="10%" align="center">{{subItem.mp}}</td>
        				<td width="7%" align="center">{{subItem.won}}</td>
        				<td width="7%" align="center">{{subItem.draw}}</td>
        				<td width="7%" align="center">{{subItem.lose}}</td>
                        <td width="17%" align="center">{{subItem.gf}}/{{subItem.ga}}</td>
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
    methods:{
        isEmpty: _.isEmpty,
        getSex(){
           return `暂无${this.type == 'men'?'男':'女'}足数据`
        },
        hasRanks(ranks){
            const keys = ["A","B","C","D","E","F","G"]
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
