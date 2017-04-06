<template>
    <section class="worldpre-rank-wrap">
        <!-- <loading :show="isLoading" text="" position="absolute"></loading> -->
		<worldpre-tab :tab.sync="tab"></worldpre-tab>
		<section class="swiper-container" v-if="!isLoading">
            <worldpre-tab-standings-rank :datas.sync="rankdata['w173']" v-if="tab =='asia'" :leaguename.sync="league_name" :code="'w173'"></worldpre-tab-standings-rank>
            <worldpre-tab-standings-rank :datas.sync="rankdata['w172']" v-if="tab =='europe'" :leaguename.sync="league_name" :code="'w172'"></worldpre-tab-standings-rank>
            <worldpre-tab-standings-rank :datas.sync="rankdata['w174']" v-if="tab =='s-america'" :leaguename.sync="league_name" :code="'w174'"></worldpre-tab-standings-rank>
            <worldpre-tab-standings-rank :datas.sync="rankdata['w175']" v-if="tab =='nc-america'" :leaguename.sync="league_name" :code="'w175'"></worldpre-tab-standings-rank>
            <worldpre-tab-standings-rank :datas.sync="rankdata['w176']" v-if="tab =='africa'" :leaguename.sync="league_name" :code="'w176'"></worldpre-tab-standings-rank>
            <worldpre-tab-standings-rank :datas.sync="rankdata['w177']" v-if="tab =='oceanica'" :leaguename.sync="league_name" :code="'w177'"></worldpre-tab-standings-rank>
		</section>
	</section>
</template>

<script>
import { getSoccerWorldPre } from '../common/models'
import _ from 'underscore'
import { Loading } from 'components'
import { getInfo, sendHideLoading } from 'common/app'
import {
    worldpreTab,
    worldpreTabStandingsRank
} from '../components'

export default {
    components:{
        Loading,
        worldpreTab,
        worldpreTabStandingsRank
    },
    data() {
        return {
            tab: "asia",
            code: "w173",
            league_name: "",
            rankdata: {},
            isLoading: true
        }
    },
    ready() {
        getSoccerWorldPre.execute(({data}) => {
            this.rankdata = data.data;
            this.league_name = data.league_name;
            this.isLoading = false
            sendHideLoading()
        })
    },
    methods:{
        isEmpty: _.isEmpty
    }
}
</script>

<style lang="less">
.worldpre-rank-wrap{
    font-size: 13px !important;
    background: #f5f4f3;
}
.night .worldpre-rank-wrap{
    background-color: #1f1f1f
}
</style>
