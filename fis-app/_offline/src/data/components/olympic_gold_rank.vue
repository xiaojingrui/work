<template>
    <scroller lock-x>
    <section class="gold-rank">
    	<table class="mod-title">
    		<thead>
    			<tr>
    				<td width="12%" align="center">排行</td>
    				<td width="40%" colspan="2" align="left">国家/地区</td>
    				<td width="12%" align="center" class="gold">金牌</td>
    				<td width="12%" align="center" class="silver">银牌</td>
    				<td width="12%" align="center" class="bronze">铜牌</td>
            <td width="12%" align="center">总数</td>
    			</tr>
    		</thead>
    	</table>
    	<table class="mod-table">
    		<tbody>
    			<tr class="link tap" v-for="(index, item) in rank[0].ranks_data">
    				<td width="12%" align="center">
                        <span class="num">{{index+1}}</span>
                    </td>
                    <td width="12%" align="left">
            			<span class="logo"><img width="28" v-bind:src="item.logo" /></span>
                    </td>
                    <td width="28%" align="left">{{item.name}}</td>
    				<td width="12%" align="center">{{item.gold}}</td>
    				<td width="12%" align="center">{{item.silver}}</td>
    				<td width="12%" align="center">{{item.bronze}}</td>
    				<td width="12%" align="center">{{item.total}}</td>
    			</tr>
    		</tbody>
    	</table>

    </section>
    </scroller>
</template>

<script>
import { Scroller } from 'components'

export default {
    components:{
      Scroller
    },
    props:{
        rank: Array
    }
}
</script>

<style lang="less">
.gold-rank {

    overflow: auto;

    .gold { color: #e5b950;}
    .silver { color: #abacae;}
    .bronze { color: #a97c46;}

    .mod-title {
    	thead {
    		tr {
                border-top: none;
    		}
    	}
    }
}
body.night {
    .gold-rank {
        .gold { color: #896f30;}
        .silver { color: #676768;}
        .bronze { color: #654a2a;}
    }
}
</style>
