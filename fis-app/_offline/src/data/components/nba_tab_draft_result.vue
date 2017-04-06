<template>
    <section class="draft-result mod-rank">
    		<div class="nav">
            <ul>
                <li v-for="item in datas" v-class="{active: item@index === 0}"><a href="javascript:void(0);">{{item.name}}</a></li>
            </ul>
    		</div>
    		<ul class="main">
    				<li v-for="item in datas">
    					<table class="mod-title title">
    						<thead>
    							<tr>
    								<td width="100" colspan="5" class="type">{{item.name}}</td>
    							</tr>
    						</thead>
    					</table>
    					<table class="mod-table">
    						<tbody>
    							<tr v-for="subItem in item.data" v-touch:tap="goto(subItem)">
    								<td width="8%" align="center"><span class="num">{{subItem.rank}}</span></td>
    								<td width="20%" class="td2">{{subItem.team_draft}}</td>
    								<td width="12%">
    									<span class="logo">
                                            <img class="lazy" data-original="{{subItem.photo}}"/>
                                            <span v-if="night" class="mask"></span>
                                        </span>
    								</td>
    								<td width="26%" class="td4">{{subItem.alias}}</td>
    								<td width="36%" class="td5">
    									<div class="info">{{subItem.position}}&nbsp;{{subItem.height}}</div>
    									<div class="other" v-if="subItem.team">交易至{{subItem.team}}</div>
    								</td>
    							</tr>
    						</tbody>
    					</table>
    				</li>
    		</ul>
    	</script>
    </section>
</template>

<script>
export default{
    props :{
        datas: Array,
        night: Boolean
    },
    methds: {
        goto(data){

        }
    }
}
</script>

<style lang="less">
.draft-result {
	.td2, .td4, .td5 {
		line-height: normal;
	}

	.td5 { color: $morning_gray2_cor;}

	.num {
		width: 14px;
	}

	.no-result {
		padding: 10px;
		color: $morning_gray2_cor;

		p {
			margin-bottom: 10px;
		}
	}
}

body.night {
	.draft-result {
		.td5 { color: $night_gray2_cor;}

		.no-result {
			color: $night_gray2_cor;
		}
	}
}
</style>
