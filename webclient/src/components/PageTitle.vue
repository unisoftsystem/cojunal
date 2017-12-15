<template>
  <div class="page-title">
    <h3 class="title title-page">{{ title }}</h3>
  </div>
</template>

<script>
  export default {
    name: 'PageTitle',
    components: {
    },
    props: {
    },
    data() {
      return {
        title: this.$route.meta.title,
      };
    },
    methods: {
    },
    created() {
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .title.title-page {
    background: #fff;
    color: #134695;
    display: inline-block;
    min-width: 200px;
    text-align: center;
  }
  .title.title-page {
    font-family: 'Avenir LT Std 45 Book';
    font-size: 14px;
  }
</style>
