<template>
    <section class="mod-worldpre-rank">
        <scroller lock-x>
    	<div class="main">

            <div v-for="(index, item) in datas" style="margin-bottom:5px">
			<table class="mod-title title">
				<thead>
					<td width="10%" align="center">
                        {{title(index)}}
					</td>
					<td width="32%" colspan="2" align="left">球队</td>
					<td width="10%" align="center">场次</td>
					<td width="7%" align="center">胜</td>
					<td width="7%" align="center">平</td>
					<td width="7%" align="center">负</td>
					<td width="17%" align="center">进/失</td>
					<td width="10%" align="center">积分</td>
				</thead>
			</table>
			<table class="mod-table">
				<tbody>
					<tr class="link tap" @click="goto(subItem)" v-for="subItem in item">
	    				<td width="10%" align="center">
							<!--
							* 亚洲 w173
							* 小组前二出线（标红色），小组第三进附加赛（标黄色）
							*
							* 欧洲 w172
							* 小组第一出线（标红色），小组第二进下一轮（标黄色）
							*
							* 南美 w174
							* 小组前四出线（标红色），小组第五进下一轮（标黄色）
							*
							* 中北美 w175
							* 小组前二出线（标红色）
							*
							* 非洲 w176
							* 小组第一出线（标红色）
							*
							* 大洋洲 w177
							* 小组第一进下一轮（标黄色）
							*
                            -->
	                        <span class="num" :class="getClass(subItem)">{{subItem.rank}}</span>
	                    </td>
	                    <td width="10%" align="left">
	    					<span class="logo">
                                <img width="28" :src="subItem.logo" />
                            </span>
	                    </td>
	                    <td width="22%" align="left">{{subItem.name}}</td>
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

			<div class="rule" :class="{'short-rule': code == 'w176'}">
				<i></i>
				<p v-if="code == 'w173'">当前为亚洲区第3轮，小组前两名直接出线，两个组的第三名进入亚洲区第4轮进行主客场对决，胜者将与中北美赛区第5轮的小组第四进行附加赛，胜者出线。</p>
				<p v-if="code == 'w172'">当前为欧洲区第1轮，九个小组的第一直接出线，八个成绩最好的第二名进入第2轮，分四组进行主客场对决，四个胜者出线。</p>
				<p v-if="code == 'w174'">南美十支球队将进行主客场双循环比赛，前四名直接出线，第五名将与大洋洲胜者进行附加赛，胜者出线。</p>
				<p v-if="code == 'w175'">当前为中北美区第5轮，六支队伍在一个组内进行主客场对决，前三名出线，第四名将与亚洲区第4轮的胜者进行附加赛，胜者出线。</p>
				<p class="short" v-if="code == 'w176'">当前为非洲区第3轮，五个小组的第一名出线。</p>
				<p v-if="code == 'w177'">当前为大洋洲区第3轮，两个小组的第一名将进行主客场对决，胜者将与南美洲第五名进行附加赛，胜者出线。</p>
			</div>
    	    <div v-if="!datas.length" class="no-data">暂无数据</div>
    	</div>
        </scroller>
    </section>
</template>

<script>
import { go } from 'common/router'
import { Scroller } from 'components'

export default {
    components: {
        Scroller
    },
    props:{
        rank: Object,
        datas: Array,
        code: String,
        leaguename: String
    },
    computed:{
        data(){
            return this.rank[this.code]
        }
    },
    methods:{
        title( index = 0 ){
            if(this.code == 'w174' || this.code == 'w175') return '排行'

            let list = ['A','B','C','D','E','F','G','H','I']
            return `${list[index]}组`
        },
        goto( data ){
            if(data.tid){
                go(`kanqiu://soccerleagues/${this.leaguename}/team/${data.tid}`);
            }
        },
        getClass(data){
            switch (this.code){
                case 'w173':
                    if(data.rank < 3){
                        return 'red'
                    }else if(data.rank == 3){
                        return 'yellow'
                    }
                    break;
                case 'w172':
                    if(data.rank == 1){
                        return 'red'
                    }else if(data.rank == 2){
                        return 'yellow'
                    }
                    break;
                case 'w174':
                    if(data.rank < 5){
                        return 'red'
                    }else if(data.rank == 5){
                        return 'yellow'
                    }
                    break;
                case 'w175':
                    if(data.rank < 4){
                        return 'red'
                    }else if(data.rank == 4){
                        return 'yellow'
                    }
                    break;
                case 'w176':
                    if(data.rank == 1){
                        return 'red'
                    }
                    break;
                case 'w177':
                    if(data.rank == 1){
                        return 'yellow'
                    }
                    break;
            }
        }
    }
}
</script>

<style lang="less">
@import "../styles/theme.less";

.mod-rank {
    overflow: auto;
}

.mod-title {
	width: 100%;
    background-color: @morning_white_cor;

	thead {
		tr {
            height: 24px;
			font-weight: bold;
			color: @morning_gray3_cor;
			border-bottom: 1px solid @morning_gray0_cor;
		}
	}
}

.mod-table {
	width: 100%;
    margin-bottom: 5px;
    background-color: @morning_white_cor;
	tbody {
		tr {
			height: 35px;
			border-bottom: 1px solid @morning_gray0_cor;

            //td:nth-of-type(3) { line-height: normal;}
		}
	}

    .num { font-weight: bold;}

	.tap:active {
		background-color: #e1e6eb;
	}
}

.mod-table:last-child { margin-bottom: 0;}

.no-data {
	width: 100%;
	background-color: @morning_white_cor;
	text-align: center;
    font-size: 14px;
	color: @morning_gray2_cor;
}
.vs-standings-wrap {
    .mod-title thead tr {
        border-top: 1px solid @morning_gray0_cor;
    }
}

.red {
    color: @morning_red_cor;
}

.yellow {
    color: #f5be00;
}

.rule {
    padding: 3px 10px;
    margin-bottom: 2px;
    i {
        display: block;
        width: 10px;
        height: 20px;
        background-image: url(http://w10.hoopchina.com.cn/hybrid/static/match/widget/worldpre_tab_standings_rank/icon_25ab893.png);
        background-size: cover;
    }

    p {
        margin-left: 18px;
        margin-top: -24px;
        line-height: 14px;
        text-align: justify;
        font-size: 11px;
        color: @morning_gray2_cor;
    }

    .short {
        margin-top: -19px;
    }
}

body.night {
    color: @night_gray3_cor;
	background-color: @night_gray1_cor !important;

    .mod-title {
        background-color: @night_white_cor;
    	thead {
    		tr {
    			color: @night_gray3_cor;
    			border-bottom-color: @night_gray0_cor;
    		}
    	}
    }

    .mod-table {
        background-color: @night_white_cor;
    	tbody {
    		tr {
    			border-bottom-color: @night_gray0_cor;;
    		}
    	}

    	.tap:active {
    		background-color: #1f1f1f;
    	}
    }

    .no-data {
        background-color: @night_white_cor;
    	color: @night_gray2_cor;
    }
    .vs-standings-wrap {
        .mod-title thead tr {
            border-top-color: @night_gray0_cor;
        }
    }

    .red {
        color: @night_red_cor;
    }

    .yellow {
        color: #7a5f00;
    }

    .rule {
        i {
            background-image: url(http://w10.hoopchina.com.cn/hybrid/static/match/widget/worldpre_tab_standings_rank/icon_night_b3bb852.png);
        }

        p {
            color: @night_gray2_cor;
        }
    }
}
</style>
