<template>
    <section class="basketball mod-rank-wrap cba">
      <!-- <loading :show="isLoading" text="" position="absolute"></loading> -->
      <basketball-tab :type.sync="pagename" :tab.sync="tab" @tab-change="onTabClick"></basketball-tab>
      <section class="swiper-container">
          <cba-tab-team-rank :datas.sync="datas" v-if="tab =='team' && datas.length"></cba-tab-team-rank>
          <basketball-tab-player-data :datas.sync="preData" :night.sync="night" :match.sync="pagename" v-if="tab =='pre' && preData.length"></basketball-tab-player-data>
          <basketball-tab-daily-data :datas.sync="todayData" :night.sync="night" :match.sync="pagename" v-if="tab =='today' && todayData.length"></basketball-tab-daily-data>
      </section>
  </section>
</template>

<script>
import { getCBATeam, getCBAPlayerRank } from '../common/models'
import { getInfo, sendHideLoading } from 'common/app'
import { Loading } from 'components'

import {
    basketballTab,
    basketballTabPlayerData,
    basketballTabDailyData,
    cbaTabTeamRank
} from '../components'

export default {
  components: {
      Loading,
      basketballTab,
      basketballTabPlayerData,
      basketballTabDailyData,
      cbaTabTeamRank
  },
  ready(){
      getCBATeam.execute(res => {
          this.datas = res.data.standings
          this.isLoading = false
          sendHideLoading()
      })
  },
  data () {
    return {
	  pagename: "cba",
      datas: [],
      tab: "team",
      night: !!getInfo().night,
      isLoading: true,
      preData: [],
      todayData: []
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
        getCBAPlayerRank.bind({type}).execute(res => {
            this[`${type}Data`] = res.data
            this[`${type}Status`] = true

            this.isLoading = false
            sendHideLoading()
        });
    }
  },
  route: {
    data ({to, next}) {
        this.tab = this.$route.query.tab || "team"
    }
  }
}
</script>

<style lang="less">
@import '../styles/common.less';
@import '../styles/basketball.less';
</style>
