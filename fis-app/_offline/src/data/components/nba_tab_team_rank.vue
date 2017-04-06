<template>
    <section class="team-rank mod-rank">
        <div class="nav">
            <scroller lock-x scrollbar-y v-ref:leftnav>
            <ul>
                <li v-for="(index, item) in datas"  @click="updatePos(index)" :class="{active: index == tabIndex}"><a href="javascript:void(0);">{{item.name}}</a></li>
            </ul>
            </scroller>
        </div>

        <div class="main">
            <scroller lock-x scrollbar-y :use-scroll="true" @scroll="onScroll" v-ref:scroller>
    		<ul>
    			<li v-for="item in datas" class="mod-scroller-con">
                    <div v-if="item.rank_type == 'east' || item.rank_type == 'west'">
        				<table class="mod-title title">
        					<thead>
        						<tr>
                                    <td width="45%" colspan="3" class="type"><span>{{item.name}}</span></td>
                                    <td width="15%" align="center">胜-负</td>
    								<td width="20%" align="center">胜场差</td>
    								<td width="20%" align="center">近况</td>
        						</tr>
        					</thead>
        				</table>
        				<table class="mod-table">
        					<tbody>
        						<tr class="link" style="height:35px" v-for="(subIndex, subItem) in item.data" @click="goto(subItem.tid)">
                                    <td>
    									<span class="num" :class="{'red': subIndex <= 7}">{{subIndex+1}}</span>
    								</td>
    								<td>
    									<span class="team-logo"><img class="lazy" :src="getPic(subItem.tid)" width="28" /></span>
    								</td>
    								<td>
    									<span class="name">{{subItem.name}}</span>
    								</td>
    								<td width="15%" align="center">{{subItem.win}}-{{subItem.lost}}</td>
    								<td width="20%" align="center">{{subItem.gb}}</td>
    								<td width="20%" align="center">{{subItem.strk}}</td>
        						</tr>
        					</tbody>
        				</table>
                    </div>
                    <div v-else>
                        <table class="mod-title title">
    						<thead>
    							<tr>
    								<td width="80%" colspan="3" class="type">
                                        <a v-if="item.name == '进攻效率' || item.name == '防守效率' || item.name == '回合数'" href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE?night=0&entrance=1">{{item.name}}榜</a>
                                        <span v-else>{{item.name}}榜</span>
                                        <a v-if="item.name == '进攻效率' || item.name == '防守效率' || item.name == '回合数'" class="icon-notice" href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE?night=0&entrance=1"></a>
                                    </td>
    								<td width="20%" align="center">数据</td>
    							</tr>
    						</thead>
    					</table>
    					<table class="mod-table">
    						<tbody>
    							<tr class="link" v-for="(subIndex, subItem) in item.data" @click="goto(subItem.team_id)">
    								<td>
    									<span class="num" :class="{'red': subIndex == 0}">{{subIndex+1}}</span>
    								</td>
    								<td>
    									<span class="team-logo"><img class="lazy" :src="getPic(subItem.team_id)" width="28" /></span>
    								</td>
    								<td>
    									<span class="name">{{subItem.team_alias}}</span>
    								</td>
    								<td width="20%" align="center">{{subItem.value}}</td>
    							</tr>
    							<tr class="last-tr">
    								<td colspan="5" align="center">
    									<span class="view-all link all-link tap" @click="gotoAll(item)">查看全部 &gt;</span>
    								</td>
    							</tr>
    						</tbody>
    					</table>
                    </div>
    			</li>
    		</ul>
            </scroller>
        </div>
    </section>
</template>

<script>
import _ from 'underscore'
import NbaVs from './nba_vs'
import { Scroller } from 'components'
import { go } from 'common/router'
import { getHost } from '../common/models'
import { getInfo } from 'common/app'

export default {
  components: {
    NbaVs,
    Scroller
  },
  props: {
    datas: Array,
    pagetab: String,
    tabIndex: 0,
    scrollTops: [],
    lastScrollTop: 0,
    lockScroll: false,
    initScrollStatus: false
  },
  ready(){
      this.tabIndex = 0
  },
  computed: {
      getEastWest(){
          let eastWest = []
          this.datas.map(item =>{
              if(item.rank_type == 'east' || item.rank_type == 'west'){
                  eastWest.push(item)
              }
          })
          return eastWest
      }
  },
  methods: {
    goto(tid) {
        go(`kanqiu://nba/nba/team/${tid}`)
    },
    getPic(tid){
        if(tid){
            return `http://b10.hoopchina.com.cn/games/teams/nba/1_${tid}_2x_alpha.png`
        }else{
            return ""
        }
    },
    gotoAll(data){
        go(`${getHost()}/nba/getDataRank?category=${this.pagetab}&rank_type=${data.rank_type}&page=1&client=${getInfo().client}`);
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
