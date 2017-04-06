<template>
  <div class="basketball mod-rank-wrap nba">
      <!-- <loading :show="isLoading" text="" position="absolute"></loading> -->
      <basketball-tab :type.sync="pagename" :tab.sync="tab" :lasttab.sync="pagelasttab" @tab-change="onTabClick"></basketball-tab>
      <section class="swiper-container">
         <nba-tab-team-rank :pagetab.sync="pagetab" :datas.sync="datas" v-if="tab =='team' && !isLoading"></nba-tab-team-rank>
         <basketball-tab-player-data :datas.sync="regularData" :night.sync="night" match="nba" v-if="tab =='regular' && regularData.length" :pagetab.sync="pagetab"></basketball-tab-player-data>
         <basketball-tab-daily-data :datas.sync="dailyData" :night.sync="night" match="nba" v-if="tab =='daily' && dailyData.length" :pagetab.sync="pagetab"></basketball-tab-daily-data>
         <nba-tab-hurt-info :datas.sync="injuryData" :night.sync="night" v-if="tab =='injury' && injuryData.length"></nba-tab-hurt-info>
      </section>
 </div>
</template>

<script>
import { getNBATeam, getNBAPlayerInGeneral } from '../common/models'
import { getInfo, sendHideLoading } from 'common/app'

import { Loading } from 'components'
import {
    basketballTab,
    basketballTabPlayerData,
    basketballTabDailyData,
    nbaTabHurtInfo,
    nbaTabTeamRank
} from '../components'

export default {
  components: {
      Loading,
      basketballTab,
      basketballTabPlayerData,
      basketballTabDailyData,
      nbaTabTeamRank,
      nbaTabHurtInfo
  },
  ready(){
      getNBATeam.execute(({data}) => {
          this.datas = data.data
          this.pagelasttab = data.pageLastTab
          this.pagetab = data.pageTab
          this.isLoading = false
          sendHideLoading()
      })
  },
  data () {
    return {
	  pagename: "nba",
      pagelasttab: "daily",
      pagetab: "regular",
      isLoading: true,
      tab: "",
      datas: [],
      night: !!getInfo().night,
      regularData: [],
      dailyData: [],
      injuryData: []
    }
  },
  methods: {
    onTabClick(type){
        if(!this[`${type}Status`] && type != 'team'){
            this.getData(type)
        }
    },
    getData(type){
        this.isLoading = true
        getNBAPlayerInGeneral.bind({type}).execute(res => {
            this[`${type}Data`] = res.data
            this[`${type}Status`] = true
            this.isLoading = false
            sendHideLoading()
        })
    }
  },
  route: {
    data ({to, next}) {
        this.tab = this.$route.query.tab || "team"
    }
  }
}
</script>

<style lang="less" scoped>
@import '../styles/common.less';
@import '../styles/basketball.less';
</style>
