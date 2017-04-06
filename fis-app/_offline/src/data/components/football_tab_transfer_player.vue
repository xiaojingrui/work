<template>
    <section class="transfer-player mod-rank">
    	<div class="nav">
        <scroller lock-x scrollbar-y v-ref:leftnav>
    		<ul>
            <li v-for="(index, item) in data" @click="updatePos(index)" :class="{active: index == tabIndex}"><a href="javascript:void(0);">{{item.name}}</a></li>
    		</ul>
        </scroller>
    	</div>

      <div class="main">
        <scroller lock-x scrollbar-y :use-scroll="true" @scroll="onScroll" v-ref:scroller>
    	  <ul>
              <li class="mod-scroller-con" v-for="(index, item) in dataTop">
                <table class="mod-title title">
                    <thead>
                        <tr>
                            <td width="50%" colspan="2" class="type"><span>{{item.name}}</span></td>
                            <td width="20%" align="center">转会至</td>
                            <td width="30%" align="center">转会费(欧元)</td>
                        </tr>
                    </thead>
                </table>
                <table class="mod-table">
                    <tbody>
                        <tr class="link tap" v-for="subItem in item.data" @click="goto(subItem, $event)">
                            <td width="14%">
                                <span class="logo">
                                    <img width="34" :src="subItem.photo" />
                                    <span class="mask" v-if="night"></span>
                                </span>
                            </td>
                            <td width="36%" class="td2">
                                <div class="name">{{subItem.name}}</div>
                                <div class="old-team">{{subItem.from_team_name}}(原)</div>
                            </td>
                            <td width="20%" align="center" class="td3">{{subItem.to_team_name}}</td>
                            <td width="30%" align="center" class="td4" @click="showMemo(subItem.memo)">{{subItem.fee}}
                                <i class="icon" v-if="subItem.memo"></i>
                            </td>
                        </tr>
                        <tr class="last-tr" v-if="item.is_more">
                            <td colspan="4" align="center">
                                <span class="view-all tap" @click="gotoAll(item)">查看全部 &gt;</span>
                            </td>
                        </tr>
                        <tr v-else>
                            <td colspan="4" align="center" class="no-result">暂无球员变动</td>
                        </tr>
                    </tbody>
                </table>
            </li>
    		<li class="item-team mod-scroller-con" v-for="(index, item) in dataOther">
    			<table class="mod-title title">
    				<thead>
    					<tr>
    						<td width="40%" colspan="2" class="type">
    							<span class="team-logo">
    								<img v-bind:src="item.logo" width="30" >
    							</span>
    							<span class="team-name">{{item.name}}</span>
    						</td>
    					</tr>
    				</thead>
    			</table>
                <div v-if="item.data.join.length || item.data.leave.length">
    				<table class="mod-table" v-if="item.data.join.length">
    					<thead>
    						<tr>
    							<td width="50%" colspan="2" class="type"><span class="join">加入</span></td>
    							<td width="20%" align="center">原球队</td>
    							<td width="30%" align="center">转会费(欧元)</td>
    						</tr>
    					</thead>
    					<tbody>
    						<tr v-for="(subIndex, subItem) in item.data.join"  @click="goto(subItem, $event)">
    							<td width="14%">
    								<span class="logo">
    									<img v-bind:src="subItem.photo" >
    									<span class="mask" v-if="night"></span>
    								</span>
    							</td>
    							<td width="36%" class="td2">
    								<div class="name">{{subItem.name}}</div>
    							</td>
    							<td width="20%" align="center" class="td3">
    								<div class="old-team">{{subItem.from_team_name}}</div>
    								<div class="league">{{subItem.from_league_name}}</div>
    							</td>
    							<td width="30%" align="center" class="td4" @click="showMemo(subItem.memo)">{{subItem.fee}}
                                    <i class="icon" v-if="subItem.memo"></i>
                                </td>
    						</tr>
    					</tbody>
    				</table>

    				<table class="mod-table" v-if="item.data.leave.length">
    					<thead>
    						<tr>
    							<td width="50%" colspan="2" class="type"><span class="leave">离开</span></td>
    							<td width="20%" align="center">新球队</td>
    							<td width="30%" align="center">转会费(欧元)</td>
    						</tr>
    					</thead>
    					<tbody>
    						<tr v-for="(subIndex, subItem) in item.data.leave" @click="goto(subItem, $event)">
    							<td width="14%">
    								<span class="logo">
    									<img v-bind:src="subItem.photo" />
    									<span class="mask" v-if="night"></span>
    								</span>
    							</td>
    							<td width="36%" class="td2">
    								<div class="name">{{subItem.name}}</div>
    							</td>
    							<td width="20%" align="center" class="td3">
    								<div class="old-team">{{subItem.to_team_name}}</div>
    								<div class="league">{{subItem.from_league_name}}</div>
    							</td>
    							<td width="30%" align="center" class="td4" @click="showMemo(subItem.memo)">{{subItem.fee}}
                                    <i class="icon" v-if="subItem.memo"></i>
                                </td>
    						</tr>
    					</tbody>
    				</table>
                </div>
				<table class="mod-table" v-else>
					<td colspan="4" align="center" class="no-result">暂无球员变动</td>
				</table>
    		</li>
    	</ul>
    </scroller>
    </div>
    <alert :show.sync="show" button-text="关闭">{{memo}}</alert>
    </section>
</template>

<script>
import _ from 'underscore'
import { Scroller, Alert } from 'components'
import { go } from 'common/router'
import { getHost } from '../common/models'
import { getInfo } from 'common/app'

export default {
    components: {
        Scroller,
        Alert
    },
    props: {
       night: Boolean,
       rank: Array,
       leaguename: String,
       show: false,
       memo: "",
       tabIndex: 0,
       scrollTops: [],
       lastIndex: 0,
       lockScroll: false,
       initScrollStatus: false
   },
   ready(){
        this.tabIndex = 0
   },
   computed: {
       data(){
           let datas = []
           this.rank[3].ranks_data.map(item =>{
               if(item.data){
                   datas.push(item)
               }
           })
           return datas
       },
       dataTop(){
           let datas = []
           this.rank[3].ranks_data.map(item =>{
               if(item.name == '最近' || item.name == 'TOP20'){
                   datas.push(item)
               }
           })
           return datas
       },
       dataOther(){
           let datas = []
           this.rank[3].ranks_data.map(item =>{
               if(item.name != '最近' && item.name != 'TOP20'){
                   datas.push(item)
               }
           })
           return datas
       }
   },
   methods: {
       goto(data, e) {
           if((e.target.className === "td4" && e.target.querySelector(".icon")) || e.target.className === "icon"){
             return
           }
           if(this.leaguename != 'afccl'){
               go(`kanqiu://soccerleagues/${this.leaguename}/player/${data.player_id}`)
           }
       },
       limit(arr){
           return arr.slice(0, 5)
       },
       showMemo( msg ){
          if(msg){
              this.show = true
              this.memo = msg
          } else{
              this.show = false
          }
       },
       gotoAll(data){
           go(`${getHost()}/data/footballAllTransfer?league_name=${this.leaguename}&rank_type=${data.rank_type}&page=1&client=${getInfo().client}`);
       },
       initScroll(){
            if(this.initScrollStatus) return
            this.initScrollStatus = true

            this.scrollTops = []
            let childs = this.$refs.scroller.$el.querySelectorAll(".mod-scroller-con");
            for(let i = 0, len = childs.length;i < len;i++){
                this.scrollTops.push(childs[i].offsetTop)
            }
        },
       updatePos(index) {
            this.initScroll()

            this.tabIndex = index
            this.lastIndex = index

            this.lockScroll = true
            this.$nextTick(() => {
                let top = this.scrollTops[index]
                this.$refs.scroller.reset({
                  top: top
                })
                this.lockScroll = false
            })
        },
        updateTabIndex(index){
            if(index != this.tabIndex){
                 let navChilds = this.$refs.leftnav.$el.querySelectorAll("li")
                 let current = navChilds[index]
                 let top = _.isElement(current) ? current.offsetTop : 0
                 let scrollerTop = this.$refs.leftnav._xscroll.getScrollTop()
                 let scrollHeight = this.$refs.leftnav.$el.offsetHeight
                 //先确定滚动方向
                 let der = index < this.tabIndex ? 'up' : 'down'
                 //向下滚动
                 if(der == "down"){
                     if(scrollerTop + scrollHeight - 60 > top){
                         return
                     }
                     top = top - scrollHeight + 60
                 } else{
                //向上滚动
                     if(scrollerTop < top){
                         return
                     }
                 }
                 //设置左侧滚动条高度
                 this.$refs.leftnav.reset({
                   top: top
                 })
            }
        },
       onScroll(e){
            if(this.lockScroll) return;
            this.initScroll()

            this.$nextTick(() => {
                const scrollTops = this.scrollTops
                const lastTop = scrollTops[this.lastIndex];
                let index = 0,
                    min = 0,
                    max = scrollTops.length

                if(e.scrollTop > lastTop){
                    min = this.lastIndex
                } else{
                    max = this.lastIndex
                }

                for(let i = min;i < max; i++){
                    const scrollTop = scrollTops[i];
                    if(scrollTop <= e.scrollTop){
                        index = i
                    }
                }
                this.updateTabIndex(index)
                this.tabIndex  = index
                this.lastIndex = index
            })
        }
   }
}
</script>
<style lang="less">
@import "../styles/theme.less";

.transfer-player {
	.td2, .td3, .td4 { line-height: normal;}
	.td4 { word-break: break-all;}

	.logo {
		margin-left: 6px;
		margin-right: 6px;
	}
    .mod-table .old-team, .league {
		font-size: 11px;
		color: @morning_gray2_cor;
	}

	.icon {
		position: relative;
		top: 2px;
		left: 2px;
		display: inline-block;
		width: 13px;
		height: 13px;
		background-image: url(http://w10.hoopchina.com.cn/hybrid/static/match/widget/football_tab_transfer_player/icon_468d079.png);
        -webkit-background-size: cover;
        background-size: cover;
	}

	.item-team {
		thead td:nth-of-type(1) {
			padding-left: 0;
		}

		.mod-table thead tr {
			font-weight: bold;
		    color: @morning_gray3_cor;
		    background-color: @morning_white_cor;
		}

		.mod-table tbody tr {
			border-bottom: none;
		}

		.mod-table tbody tr:last-child {
			border-bottom: 1px solid @morning_gray0_cor;
		}

		.mod-table thead td {
			line-height: 22px;
			padding-top: 2px;
			padding-bottom: 2px;
		}

		.mod-table thead td:nth-of-type(1) {
			padding-left: 6px;
		}

		.team-name {
			position: relative;
			top: 2px;
		}

		.team-logo {
			margin-left: 2px;
		}

		.old-team {
			font-size: 13px;
			color: @morning_gray3_cor;
		}

		.last-tr {
			border-top: 1px solid @morning_gray1_cor;
		}
	}

	.cost {
		padding-right: 15px;
		font-weight: normal;
		font-size: 12px;
		color: @morning_gray2_cor;
	}

	.join { color: #2d991b;}
	.leave { color: @morning_red_cor;}

	.no-result { color: @morning_gray2_cor;}
}

.night{
    .transfer-player {
        .mod-table .old-team, .league {
    		color: @night_gray2_cor;
    	}

    	.icon {
    		background-image: url(http://w10.hoopchina.com.cn/hybrid/static/match/widget/football_tab_transfer_player/icon_night_af354b4.png);
    	}

    	.item-team {
    		.mod-table thead tr {
    		    color: @night_gray3_cor;
    		    background-color: @night_white_cor;
    		}

    		.mod-table tbody tr:last-child {
    			border-bottom-color: @night_gray0_cor;
    		}

    		.old-team {
    			color: @night_gray3_cor;
    		}

    		.last-tr {
    			border-top-color: @night_gray1_cor;
    		}
    	}

    	.cost {
    		color: @night_gray2_cor;
    	}

    	.join { color: #1b5c10;}
    	.leave { color:  @night_red_cor;;}

    	.no-result { color: @night_gray2_cor;}
    }
}
</style>
