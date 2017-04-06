<template>
    <section class="player-data mod-rank">
		<div class="nav">
            <scroller lock-x scrollbar-y v-ref:leftnav>
			<ul>
				<li v-for="(index,item) in datas" @click="updatePos(index)" :class="{active: index == tabIndex}"><a href="javascript:void(0);">{{item.name}}</a></li>
			</ul>
            </scroller>
		</div>

        <div class="main">
            <scroller lock-x scrollbar-y :use-scroll="true" @scroll="onScroll" v-ref:scroller>
        		<ul>
        			<li v-for="(index, item) in datas" class="mod-scroller-con">
        				<table class="mod-title title">
        					<thead>
        						<tr v-if="isFivePlayer(item)">
                                    <td width="55%" colspan="2" class="type">{{item.name}}榜</td>
									<td width="15%" align="center">球队</td>
									<td width="15%" align="center">时间</td>
									<td width="15%" align="center">+/-</td>
        						</tr>
                                <tr v-else>
                                    <td width="66%" class="type">
                                        <a v-if="hasJinjie(item.name)" :href="jinjie">{{item.name}}榜</a>
                                        <span v-else>{{item.name}}榜</span>
                                        <a v-if="hasJinjie(item.name)" class="icon-notice" :href="jinjie"></a>
                                    </td>
        							<td width="20%" align="center">球队</td>
        							<td width="14%" align="center">数据</td>
        						</tr>
        					</thead>
        				</table>
        				<table class="mod-table">
        					<tbody>
        						<tr class="link tap" v-for="(subIndex,subItem) in item.data" @click="goto(subItem, item)">
        							<td width="66%" v-if="!isFivePlayer(item)">
        								<span class="num" :class="{red: subItem.rank === 1}" v-text="subItem.rank"></span>
        								<span class="logo">
                                            <img v-bind:src="subItem.player_header" />
                                            <span class="mask" v-if="night"></span>
                                        </span>
        								<span class="detail">
        									<span class="name">{{subItem.player_name}}</span>
        									<span class="others" v-if="subItem.pts && subItem.reb && subItem.asts">
        										{{subItem.pts}}分
        										{{subItem.reb}}板
        										{{subItem.asts}}助
        									</span>
        								</span>
        							</td>
        							<td width="20%" align="center" v-if="!isFivePlayer(item)">{{subItem.team_name}}</td>
        							<td width="14%" align="center" v-if="!isFivePlayer(item)">{{item.en != 'win_time' ? subItem.val: subItem.avg_points}}{{item.en =='salary'?'万':''}}</td>


                                    <td v-if="isFivePlayer(item)">
										<span class="num" :class="{red: subItem.rank == 1}">{{subItem.rank}}</span>
									</td>
									<td v-if="isFivePlayer(item)">{{subItem.data_name}}</td>
									<td v-if="isFivePlayer(item)" width="15%" align="center">{{subItem.team_name}}</td>
									<td v-if="isFivePlayer(item)" width="15%" align="center">{{parseFloat(subItem.val/60).toFixed(1)}}</td>
									<td v-if="isFivePlayer(item)" width="15%" align="center">
                                        {{parseFloat(subItem.avg_plus_minus) > 0 ? '+':''}}{{parseFloat(subItem.avg_plus_minus).toFixed(1)}}
									</td>
        						</tr>

        						<tr v-if="item.is_more" class="last-tr">
        							<td colspan="3" align="center">
        								<span class="view-all tap" @click="gotoAll(item)">查看全部 &gt;</span>
        							</td>
        						</tr>
                                <tr v-if="item.data.length == 0" class="last-tr">
                                    <td colspan="3" align="center">
										暂无数据
									</td>
        						</tr>
        					</tbody>
        				</table>
        			</li>
        		</ul>
            </scroller>
        </div>
    </section>
</template>

<script>
import _ from 'underscore'
import { Scroller } from 'components'
import { go } from 'common/router'
import { getHost } from '../common/models'
import { getInfo } from 'common/app'

export default {
    components: {
        Scroller
    },
    props: {
        datas: Array,
        night: Boolean,
        match: String,
        pagetab: String,
        tabIndex: 0,
        scrollTops: [],
        lastIndex: 0,
        lockScroll: false,
        initScrollStatus: false,
        jinjie: String
    },
    ready(){
        this.tabIndex = 0
        this.jinjie = 'https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE?night=0&entrance=1'
    },
    methods: {
        goto(data, mom) {
            if(this.match == 'nba'){
                if(mom.en == 'five_player'){
                    go(`kanqiu://nba/nba/team/${data.team_id}`)
                }else{
                    go(`kanqiu://nba/nba/player/${data.player_id}`)
                }
            } else{
                go(`kanqiu://cba/cba/player/${data.player_id}`)
            }
        },
        gotoAll(data){
            let queryBase = this.match == 'nba' ? '/nba/getDailyPlayer' : '/cba/getPlayerAllPreRank'
            let type = `type=${data.en}`
            go(`${getHost()}${queryBase}?category=${this.pagetab||''}&${type}&page=1&client=${getInfo().client}`);
        },
        isFivePlayer(data){
            return data.en == 'five_player'
        },
        isNBA(){
            return this.match == 'nba'
        },
        hasJinjie(name){
            let one = ~['eFG%','TS%','失误率','PER','WS','OWS','DWS','USG%','罚球率','进攻效率','防守效率'].indexOf(name) && this.isNBA()
            let two = ~['真实命中率','有效命中率','失误率'].indexOf(name) && !this.isNBA()
            return one || two
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

</style>
