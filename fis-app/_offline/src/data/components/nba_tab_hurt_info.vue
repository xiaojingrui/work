<template>
    <section class="hurt-info mod-rank">
		<div class="nav">
        <scroller lock-x scrollbar-y>
          <ul v-if="datas.length">
              <li v-for="(index, item) in datas" @click="updatePos(index)" :class="{active: index == tabIndex}"><a href="javascript:void(0);">{{item.name}}</a></li>
          </ul>
        </scroller>
		</div>

    <div class="main">
    <scroller lock-x scrollbar-y :use-scroll="true" @scroll="onScroll" v-ref:scroller auto-scroll-to-bottom>
		<ul>
			<li v-for="(index, item) in datas" class="mod-scroller-con">
				<table class="mod-title title">
					<thead>
						<tr>
							<td width="50%" class="type">{{item.name}}</td>
							<td width="20%" align="center">伤停</td>
							<td align="center">最新进展</td>
						</tr>
					</thead>
				</table>
				<table class="mod-table">
					<tbody>
						<tr class="link tap" v-for="subItem in hasData(item.data)" @click="goto(subItem)">
							<td width="50%" >
									<span class="logo" style="margin-left: 5px;">
                                        <img :src="subItem.player_photo"/>
										<span v-if="night" class="mask"></span>
									</span>
								<span class="detail">
									<span class="name">{{subItem.alias}}</span>
									<span class="others">
										{{subItem.team_name}}
									</span>
								</span>
							</td>
							<td  width="20%"  align="center">
								{{subItem.injury_part_cn ||  subItem.injury_part}}
							</td>
							<td align="center">
								<span class="injury_returns_en">{{subItem.injury_returns_cn || subItem.injury_returns}}</span>
							</td>
						</tr>
						<tr class="last-tr" v-if="item.is_more">
							<td colspan="4" align="center">
								<span class="view-all tap" @click="gotoAll(item.allURL)">查看全部 &gt;</span>
							</td>
						</tr>
						<tr v-if="!item.data.length">
							<td align="center" class="no-data">暂无伤停球员</td>
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
import { Scroller } from 'components'
import { go } from 'common/router'
import { getHost } from '../common/models'

export default {
    components: {
        Scroller
    },
    props:{
        datas: Array,
        night: Boolean,
        tabIndex: 0,
        scrollTops: [],
        lastIndex: 0,
        height: `${document.documentElement.clientHeight - 40}px`,
        lockScroll: false,
        initScrollStatus: false
    },
    ready(){
        this.tabIndex = 0
    },
    methods:{
        goto(data) {
            go(`kanqiu://nba/nba/player/${data.hupu_pid}`)
        },
        gotoAll(url){
            go(`${getHost()}${url}`);
        },
        hasData(list){
            return list.length ? list : []
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
                this.tabIndex  = index
                this.lastIndex = index
            })
        }
    }
}
</script>

<style lang="less">
.injury_returns_en {
    font-size: 12px;
    width: 100%;
    display: block;
    line-height: 18px
}
</style>
