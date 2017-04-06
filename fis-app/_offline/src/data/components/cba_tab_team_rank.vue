<template>
    <section class="team-rank">
    <scroller lock-x scrollbar-y>
   	<div class="main">
   		<table class="mod-title">
   			<thead>
   				<tr>
   					<td width="40%" class="type">球队</td>
   					<td width="20%" align="center">场次</td>
   					<td width="10%" align="center">胜</td>
   					<td width="10%" align="center">负</td>
   					<td width="20%" align="center">胜率</td>
   				</tr>
   			</thead>
   		</table>
   		<table class="mod-table">
   			<tbody>
   				<tr class="link tap" v-for="(index, item) in datas" @click="goto(item)">
   					<td width="40%">
   						<span class="num" :class="{red: index+1 <= 8}" v-text="index+1"></span>
   						<span class="logo"><img v-bind:src="withSrc(item)" width="28" /></span>
                        <span class="name">{{item.name}}</span>
   					</td>
   					<td width="20%" align="center">{{item.bout}}</td>
   					<td width="10%" align="center">{{item.win}}</td>
   					<td width="10%" align="center">{{item.los}}</td>
   					<td width="20%" align="center">{{item.rate}}</td>
   				</tr>
   			</tbody>
   		</table>
   	</div>
   </scroller>
   </section>
</template>

<script>
import { Scroller } from 'components'
import { go } from 'common/router'

export default {
    components: {
        Scroller
    },
    props:{
        datas: Array
    },
    methods:{
        goto (data){
            go(`kanqiu://cba/cba/team/${data.id}`)
        },
        withSrc(item){
            const last = (item.id == 14 || item.id == 21) ? '_new' : (item.id == 12) ? '_1' : '';
            return `http://b1.hoopchina.com.cn/games/teams/cba/2_${item.id}${last}.png`
        }
    }
}
</script>
