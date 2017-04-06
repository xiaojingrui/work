<template>
<div class="container news-container">
  <router-view  transition="fade" transition-mode="out-in" keep-alive></router-view>
</div>
</template>

<style lang="less">
@import '../../styles/reset.less';
body{
    background-color: #fff;
}
.news-container{
    .weui_toast{
        background: rgba(40, 40, 40, 0.75);
    }
}
</style>
