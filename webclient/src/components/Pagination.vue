<template>
  <div class="pagination">

    <div class="pagination-container">
    </div>

    <div class="pagination-container">
      <div class="">
        Anterior &nbsp; 
      </div>

      <div :class="{'active': index === pageSelect}" 
        class="page-indicator" 
        v-for="(p, index) in getCantPages()"
        @click="setPageSelect(index)">
        {{ (index + 1) }}
      </div>

      <div class="">
        &nbsp; Siguiente
      </div>
    </div>

  </div>
</template>

<script>
  export default {
    name: 'Pagination',
    components: {
    },
    props: {
      cantPage: { required: true, type: Number },
      total: { required: true, type: Number },
    },
    data() {
      return {
        buttons: Array(0),
        pageSelect: -1,
      };
    },
    methods: {
      getCantPages() {
        return Array(Math.ceil(this.total / this.cantPage));
      },
      setPageSelect(index) {
        this.pageSelect = index;
      },
    },
    created() {
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .pagination {
    overflow: hidden;
    width: 100%;
    background-color: white;
  }
  .pagination-container {
    align-items: center;
    padding: 20px 20px 0 20px;
    display: -webkit-inline-box;
    display: -ms-inline-flexbox;
    display: flex;
    justify-content: flex-end;
  }
  .page-indicator {
    cursor: pointer;
    -webkit-transition: all 0.2s ease-out;
    transition: all 0.2s ease-out;
    -webkit-appearance: none;
    background: #fff;
    border: none;
    -webkit-border-radius: 2px;
    display: block;
    border-radius: 0px;
    margin: 0 0 10px 0;
    padding: 8px 12px 9px 12px;
    border: 1px solid #d7d7d7;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    height: 35px;
    width: 35px;
    font-family: 'avenir';
    font-size: 14px;
    color: #a6a6a6;
    display: inline-block;
    margin-right: 2px;
  }    
  .active {
    background-color: #134695;
    color: white;
  }
</style>