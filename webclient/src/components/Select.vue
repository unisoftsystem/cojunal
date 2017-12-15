<template>
  <div class="select">

    <div class="select-container">
      <select @change="change(name, getModel(), meta)" v-model="model1">
        <option v-for="(op, index) in options" :value="op.value">
          {{ op.text }}
        </option>
      </select>
    </div>

  </div>
</template>

<script>
  export default {
    name: 'Select',
    components: {
    },
    props: {
      change: { required: true },
      model: { required: true, type: String },
      options: { required: true },
      name: { required: true },
      meta: {},
    },
    data() {
      return {
        model1: null,
      };
    },
    methods: {
      getModel() {
        return this.model1;
      },
    },
    created() {
    },
    mounted() {
      this.model1 = this.model;
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .select {
  }
  .select-container {
    width: 100%;
    display: flex;
    justify-content: center;
  }
  select {
    -webkit-transition: 0.3s;
    -o-transition: 0.3s;
    -ms-transition: 0.3s;
    -moz-transition: 0.3s;
    transition: 0.3s;
    -webkit-appearance: none;
    background-color: #fff;
    background-image: url(../assets/flecha_select.png);
    background-repeat: no-repeat;
    background-position: center right 8px;
    border: 1px solid #d7d7d7;
    -webkit-border-radius: 2px;
    border-radius: 2px;
    display: block;
    padding: 8px 33px 9px 10px;
    color: #5d5d5d;
    height: auto;
    cursor: pointer;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    font-family: 'avenir';
    font-size: 14px;
    width: 100%;
    height: 100%;
    text-align: left;
    margin: 0 0 10px;
    display: flex;
    width: 100%;
    max-width: 300px;
  }
</style>