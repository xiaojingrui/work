<template>
    <section class="player-rank mod-rank">

    	<div class="nav" v-if="!isGoalsAllEmpty">
            <scroller lock-x v-ref:leftnav>
    		<ul>
    			<li v-for="(index, item) in data" @click="updatePos(index)" :class="{active: index == tabIndex}"><a href="javascript:void(0);">{{item.name}}</a></li>
    		</ul>
            </scroller>
    	</div>

        <div class="main" v-if="!isGoalsAllEmpty">
        <scroller lock-x scrollbar-y :use-scroll="true" @scroll="onScroll" v-ref:scroller>
    	<ul>
    		<li v-for="(index, item) in data" class="mod-scroller-con">
    			<table class="mod-title title">
    				<thead>
    					<tr>
    						<td width="50%" colspan="3" class="type"><span>{{item.name == "进球"?'射手':item.name}}榜</span></td>
    						<td width="25%" align="center">球队</td>
    						<td width="25%" align="center">{{item.title}}</td>
    					</tr>
    				</thead>
    			</table>
    			<table class="mod-table">
    				<tbody>
    					<tr class="link tap" v-for="(subIndex, subItem) in limit(item.data)" @click="goto(subItem)">
    						<td width="10%" align="left">
    							<span class="num" :class="{red: subItem.ranking == 1}">{{subItem.ranking}}</span>
    						</td>
    						<td width="10%" align="left">
    							<span class="logo">
    								<img v-bind:src="subItem.player_logo">
    								<span class="mask" v-if="night"></span>
    							</span>
    						</td>
    						<td width="30%" align="left">
    							<span class="name">{{subItem.player_name}}</span>
    						</td>
    						<td width="25%" align="center"><span class="team-name">{{subItem.team_name}}</span></td>
    						<td width="25%" align="center">
                                {{last(item.field, item.rank_type, subItem)}}
    						</td>
    					</tr>
    					<tr class="last-tr">
    						<td colspan="5" align="center">
    							<span class="view-all link tap" @click="gotoAll(item.rank_type)">查看全部 &gt;</span>
    						</td>
    					</tr>
    				</tbody>
    			</table>
    		</li>
    	</ul>
        </scroller>
        </div>

        <div class="mod-no-data" v-if="isGoalsAllEmpty">暂无球员榜数据</div>
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
        night: Boolean,
        rank: Array,
        leaguename: String,
        isGoalsAllEmpty: false,
        tabIndex: 0,
        scrollTops: [],
        lastScrollTop: 0,
        lockScroll: false,
        initScrollStatus: false
    },
    ready(){
        this.tabIndex = 0

        this.isGoalsAllEmpty = this.getIsGoalsAllEmpty()
    },
    computed: {
        data(){
            let datas = []
            this.rank[1].ranks_data.map(item =>{
                if(item.data && item.data.length){
                    datas.push(item)
                }
            })
            return datas
        }
    },
    methods:{
        getIsGoalsAllEmpty(){
            let ret = true
            this.rank[1].ranks_data.map(item =>{
                if(!_.isEmpty(item.data)){
                    ret = false
                }
            })
            return ret
        },
        last(field, rank_type, subItem){
            if  (rank_type== "pass_per_p"){
                    return subItem[field] * 100 + "%"
            }else{
                if (rank_type == "goals" || rank_type == "assits"){
                    return subItem[rank_type]
                }else{
                    return subItem[field]
                }
            }
        },
        limit(arr){
            return arr.slice(0, 5)
        },
        goto( data ){
            go(`kanqiu://soccerleagues/${this.leaguename}/player/${data.player_pid}`)
        },
        gotoAll(rank_type) {
            go(`${getHost()}/data/footballAllRank?league_name=${this.leaguename}&rank_type=${rank_type}&client=${getInfo().client}`)
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

            this.$nextTick(()=> {
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
