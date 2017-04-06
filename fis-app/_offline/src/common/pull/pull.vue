<template>
  <div class="load-more" :class='{"load-up": type == "up", "load-down": type =="down"}'>
    <p v-if="pulltips">{{pulltips}}</p>
  </div>
</template>

<style scoped>
.load-up{border-top:1px solid #e8e8e8;}
.load-down{border-bottom:1px solid #e8e8e8;}
.night {}
.load-more{height:30px;}
.load-more>p{text-align:center;padding:.1rem;color:#999;line-height:30px}
</style>
