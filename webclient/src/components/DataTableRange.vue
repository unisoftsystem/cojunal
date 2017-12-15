<template>
  <div class="slider">

    <div class="slider-container">
      
      <div class="input-container">
        <span @click="setShowRange" class="inp-number--content">
          <input type="text" v-model="rangeModel" :disabled="true" class="inp-number">
          <span @click="clearRange" class="close-icon"><a class="datepicker-close"></a></span>
        </span>

        <div class="range-container" v-if="showRange" v-on-clickaway="away">
          <input @input="changeValue('init', initModel)" v-model="initModel" class="input-range" type="number" placeholder="Desde">
          <input @input="changeValue('end', endModel)" v-model="endModel" class="input-range" type="number" placeholder="Hasta">
        </div>
      </div>
    </div>

  </div>
</template>

<script>
  import { mixin as clickaway } from 'vue-clickaway';

  export default {
    name: 'Range',
    mixins: [clickaway],
    components: {
    },
    props: {
      change: { required: true },
      model: { required: false, type: String },
      options: { required: false },
      name: { required: false },
      meta: {},
    },
    data() {
      return {
        model1: null,
        initModel: '',
        endModel: '',
        rangeModel: '',
        showRange: false,
      };
    },
    methods: {
      clearRange() {
        this.rangeModel = '';
        this.changeValue('init', null);
        this.changeValue('end', null);
      },
      away() {
        console.log('away', this.showRange);
        if (this.showRange === true) {
          this.showRange = true;
          this.setShowRange(true);
        }
      },
      setShowRange() {
        this.showRange = !this.showRange;
        if (this.showRange) {
          const rnge = this.rangeModel.split('/');
          console.log('setting data', rnge);
          if (rnge[0]) this.initModel = rnge[0].trim();
          if (rnge[1]) this.endModel = rnge[1].trim();
          this.rangeModel = '';
        }
        if (this.showRange || (!this.initModel && !this.endModel)) return false;
        this.rangeModel = this.initModel.concat(' / ').concat(this.endModel);
        if (!this.showRange) {
          this.initModel = '';
          this.endModel = '';
        }
        return true;
      },
      getModel() {
        return this.model1;
      },
      changeValue(type, value1) {
        let model1 = '';
        if (type) model1 = type.concat('_').concat(this.name);
        this.change({ model: model1, value: value1 });
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
  .inp-number {
    /*margin-bottom: -20px;*/
  }
  .inp-number--content:hover .close-icon {
    display: block;
  }
  .close-icon {
    display: none;
  }
  .datepicker-close {
    display: inline-block;
    top: -6px !important;
  }
  .input-container {
    position: relative;
  }
  .range-container {
    position: absolute;
    padding: 10px;
    background: white;
    min-width: 120px;
    box-shadow: 0px 5px 10px 0px #eee;
  }
  .input-range {
    outline: none;
  }
  .input-range:focus {
    box-shadow: inset 0px -2px 0px 0px #09ca69 !important;
  }
  .triangle-up {
    width: 0;
    height: 0;
    border-left: 50px solid transparent;
    border-right: 50px solid transparent;
    border-bottom: 100px solid red;
  }
</style>