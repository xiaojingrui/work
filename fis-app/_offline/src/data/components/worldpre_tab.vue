<template>
    <section class="data-tab">
    	<ul>
    		<li class="tab-asia" :class="{active: tab == 'asia'}" @click="tab = 'asia'" dace-node="worldpreasia">亚洲</li>
    		<li class="tab-europe" :class="{active: tab == 'europe'}" @click="tab = 'europe'" dace-node="worldpreeuro">欧洲</li>
    		<li class="tab-s-america" :class="{active: tab == 's-america'}" @click="tab = 's-america'" dace-node="worldpresouth">南美</li>
            <li class="tab-nc-america" :class="{active: tab == 'nc-america'}" @click="tab = 'nc-america'" dace-node="worldpreconcacaf">中北美</li>
            <li class="tab-africa" :class="{active: tab == 'africa'}" @click="tab = 'africa'" dace-node="worldpreafrican">非洲</li>
            <li class="tab-oceanica" :class="{active: tab == 'oceanica'}" @click="tab = 'oceanica'" dace-node="worldpreoceania">大洋洲</li>
    	</ul>
    </section>
</template>

<script>
export default {
    props : {
        tab : String
    },
    watch: {
        tab (newTab){
            this.$emit("tab-change", newTab)
        }
    }
}
</script>

<style lang="less">
</style>
