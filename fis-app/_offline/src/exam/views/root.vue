<template>
<div class="container">
  <router-view  transition="fade" transition-mode="out-in" keep-alive></router-view>
</div>
</template>

<style lang="less">
@import '../../styles/reset.less';
.night{
    background-color: #fff !important;
}
.fl{float: left}
.fr{float: right}
.clearfix:after {
	content: "";
	display: block;
	clear: both;
}
</style>
