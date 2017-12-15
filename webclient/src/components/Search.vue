<template>
  <div class="search">

    <div class="search-container">

      <span>Buscar: </span> &nbsp; <input @input="change(searchText)" type="text" v-model="searchText">

    </div>

  </div>
</template>

<script>
  export default {
    name: 'Search',
    components: {
    },
    props: {
      change: {
        required: true,
      },
    },
    data() {
      return {
        searchText: '',
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
  @import url('../fonts/Avenir/style.css');
  .search-container {
    display: inline-flex;
    align-items: baseline;
  }
  .search-container{
    background-color: white;
    padding: 20px 20px 0 20px;
    display: flex;
    justify-content: flex-end;
  }
  .search-container span {
  font-family:'Avenir LT Std 45 Book';
  font-weight:normal;
  font-size: 13px;
  line-height: 13px;
  color: #5d5d5d;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  padding: 0 0 0 4px;
  margin: 0 0 5px 0;
  display: block;
  }
  input {
    -webkit-transition: all 0.2s ease-out;
    -o-transition: all 0.2s ease-out;
    -ms-transition: all 0.2s ease-out;
    -moz-transition: all 0.2s ease-out;
    transition: all 0.2s ease-out;
    -webkit-appearance: none;
    background: #fff;
    border: none;
    -webkit-border-radius: 2px;
    display: block;
    border-radius: 2px;
    margin: 0 0 10px 0;
    padding: 8px 12px 9px 12px;
    border: 1px solid #d7d7d7;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    height: auto;
    font-family: 'avenir';
    font-size: 14px;
    color: #a6a6a6;
    width: 100%;
    display: inline-block;
    width: 100%;
    max-width: 280px;
  }
  input[type=text]:focus{
  border-bottom: 1px solid #09ca69;
  box-shadow: 0 1px 0 0 #09ca69;
  }
</style>
