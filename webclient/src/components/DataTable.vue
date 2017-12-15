<template>
  <div class="table-container">

    <Search v-if="search" :change="searchChange" />
    
    <!-- <div>
      <span>
        <i class="fa fa-th-list" aria-hidden="true"></i>
      </span>
    </div> -->

    <table>
      <!-- TABLE HEAD -->
      <thead>
        <tr>
          <th v-for="(h, index) in getHeadingsKeys()">
            <span @click="sort(index)" class="header-title">{{ getTitle(headings[h]) }}</span>
            <i @click="sort(index)"
              :class="{'fa fa-chevron-circle-down': index === indexSort, 'fa fa-chevron-circle-up': index !== indexSort}"
              aria-hidden="true">
            </i>
          </th>
        </tr>

        <tr v-if="fieldSearch" class="fields-search">
          <th v-for="(h, index) in getHeadingsKeys()">
            <input v-if="getInputType(headings[h].type) ==='text'" @input="searchInputChange(h, $event)" :type="getInputType(headings[h].type)">
            <span v-if="getInputType(headings[h].type) ==='select'" class="table-select-container">
              <FormSelect :change="selectHeaderChange" :name="h" :model="''" :options="getOptions(h)" :meta="h"/>
            </span>
            <span v-if="getInputType(headings[h].type) === 'date'" @click="setRangeFilter(h)">
              <vue-datepicker-local class="local-picker" :local="localPicker" v-model="range" range-separator="-" clearable/>
            </span>
            <span v-if="getInputType(headings[h].type) === 'number'" class="input-number">
              <DataTableRange :change="changeInputNumber" :name="h"/>
            </span>
          </th>
        </tr>
      </thead>

      <!-- TABLE BODY  -->
      <tbody>
        <template v-for="(t, tindex) in data">
          <!-- DATA MODEL -->
          <tr @click="handleTrClick(t, tindex)" v-b-toggle="getIdCollapse(tindex)">
            <td v-for="h in getHeadingsKeys()">
              <span v-if="getTextByType(h) === 'select'">
                <FormSelect :change="selectChange" :name="h" :model="t[h]" :options="getOptions(h)" :meta="t"/>
              </span>
              <span v-if="getTextByType(h) === 'slot'">
                <slot :name="h" :slot-scope="t"></slot>
              </span>
              <span v-if="getTextByType(h) === 'text'">{{ t[h] }}</span>
            </td>
          </tr>

          <!-- ACORDEON -->
          <tr v-if="collapse">
            <td :colspan="getHeadingsKeys().length" class="colpancollapse">
              <b-collapse :id="getIdCollapse(tindex)">
                <b-card>
                  <slot :name="'xhracordeon'" :slot-scope="t"></slot>
                </b-card>
              </b-collapse>
            </td>
          </tr>

          <!-- <b-btn v-b-toggle.collapse1 variant="primary">SYSTEM</b-btn> -->

          <!-- <tr>
            <td v-for="h in getHeadingsKeys()" @click="selectRowIn(t, tindex)">
              <span v-if="getTextByType(h) === 'select'">
                <FormSelect :change="selectChange" :name="h" :model="t[h]" :options="getOptions(h)" :meta="t"/>
              </span>
              <span v-if="getTextByType(h) === 'slot'">
                <slot :name="h" :slot-scope="t"></slot>
              </span>
              <span v-if="getTextByType(h) === 'text'">{{ t[h] }}</span>
            </td>
          </tr>
          <tr v-if="t.showAcordeon === true">
            <td :colspan="getHeadingsKeys().length">
              <slot :name="'acordeon'" :slot-scope="t"></slot>
            </td>
          </tr> -->
        </template>
      </tbody>
    </table>
    <!-- <Pagination :cantPage="cantPage" :total="total"/> -->
  </div>
</template>

<script>
  import moment from 'moment';
  import Search from '@/components/Search';
  import FormSelect from '@/components/Select';
  import Pagination from '@/components/Pagination';
  import PageTitle from '@/components/PageTitle';
  import axios from 'axios';
  import endPonit from '@/utils/env';
  import querystring from 'querystring';
  import VueDatepickerLocal from 'vue-datepicker-local';
  import datePickerLocal from '../utils/datePickerLocal';
  import DataTableRange from './DataTableRange';

  export default {
    name: 'DataTable',
    components: {
      Search,
      PageTitle,
      FormSelect,
      Pagination,
      VueDatepickerLocal,
      DataTableRange,
    },
    props: {
      headings: { required: true },
      endPoint: { required: true },
      selectRow: {
        default: false,
      },
      collapse: {
        default: false,
      },
      search: {
        default: true,
      },
      fieldSearch: {
        default: true,
      },
      acordeon: {
        default: false,
      },
      params: {
        required: false,
        default: Object,
      },
    },
    watch: {
      range(value) {
        if (!value) this.setRangeFilter(null);
        this.searchChange();
      },
    },
    data() {
      return {
        indexSort: -1,
        localPicker: datePickerLocal,
        range: [new Date(), new Date()],
        itmCollapse: 'collapse',
        sortClass: true,
        query: '',
        cantPage: 20,
        total: 100,
        rangeFilter: '',
        data: [],
        models: {},
        prms: {},
      };
    },
    methods: {
      changeInputNumber(data) {
        this.params[data.model] = data.value;
        this.searchChange(false);
      },
      setRangeFilter(prop) {
        this.rangeFilter = prop;
      },
      getIdCollapse(index) {
        return this.itmCollapse + index;
      },
      handleTrClick(t, tindex) {
        this.selectRowIn(t, tindex);
      },
      selectHeaderChange(name, value) {
        this.$set(this.prms, name, value);
        this.searchChange();
      },
      searchInputChange(name, event) {
        this.$set(this.prms, name, event.target.value);
        this.searchChange();
      },
      getInputType(type) {
        if (type === 'datetime') return 'date';
        if (type === 'select') return 'select';
        if (type === 'number') return 'number';
        return 'text';
      },
      getOptions(prop) {
        if (!this.headings[prop].enum) return [];
        return this.headings[prop].enum;
      },
      getTitle(prop) {
        if (!prop.title) return '';
        return prop.title;
      },
      getTextByType(prop) {
        if (this.headings[prop].type === 'select') return 'select';
        if (this.headings[prop].type === 'slot') return 'slot';
        return 'text';
      },
      getDataTable() {
        return this.data;
      },
      getHeadingsKeys() {
        return Object.keys(this.headings);
      },
      sort(index) {
        this.indexSort = (this.indexSort !== index) ? index : -1;
      },
      selectChange(prop, value, meta) {
        if (this.headings[prop].change) return this.headings[prop].change(value, meta);
        return null;
      },
      searchChange(value) {
        if (value) this.query = value;
        this.getData();
      },
      selectRowIn(itm, index) {
        if (this.selectRow) this.selectRow(itm, this, index);
      },
      getData() {
        let params = {
          q: this.query,
        };
        params = (this.prms) ? Object.assign(params, this.prms) : params;
        params = (this.params) ? Object.assign(params, this.params) : params;
        const init = 'init_'.concat(this.rangeFilter);
        const end = 'end_'.concat(this.rangeFilter);
        // console.log('this.rangeFilter ---->', this.rangeFilter, this.range);
        if (this.range[0]) {
          params[init] = moment(this.range[0]).format();
          params[end] = moment(this.range[1]).format();
        } else {
          params[init] = null;
          params[end] = null;
        }
        axios.post(endPonit.endPonit + this.endPoint, querystring.stringify(params)).then((res) => {
          if (res.status !== 200) return;
          this.data = [];
          res.data.map((item) => {
            if (!this.data.indexOf(item) > -1) this.data.push(item);
            return null;
          });
        }).catch((err) => {
          console.log(err);
        });
      },
    },
    created() {
    },
    mounted() {
      this.getData();
      if (window.busHub) {
        window.busHub.$on('updateTable', (prms) => {
          this.params = Object.assign(this.params, prms);
          this.getData();
        });
      }
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .card-body {
    max-height: 290px !important;
    overflow-y: scroll;
    overflow-x: scroll;
    margin: 20px auto;
  }
  .table-select-container {
    display: inline-block;
    margin-bottom: -9px;
  }
  .input-number {
    display: inline-block;
    margin-bottom: -9px;
  }
  .local-picker {
    margin-bottom: -10px;
  }
  .local-picker:before, .local-picker .datepicker-close {
    right: 0px;
    top: -5px;
  }
  .fields-search {
    padding: 0;
  }
  .fields-search:hover {
    background: transparent;
  }
  .fields-search th {
    padding: 0 !important;
  }
  .fields-search input {
    margin: 0;
    margin-bottom: 2px;
  }
  .fields-search input:focus {
    outline: none;
    box-shadow: inset 0px -2px 0px 0px #09ca69 !important;
    border-bottom: none !important;
  }
  .header-title {
    cursor: pointer;
    color: #5d5d5d;
    font-family:'Avenir LT Std 45 Book';
    font-weight:bold;
    font-size: .9rem;
    /*line-height: 13px;*/
  }
  i {
    cursor: pointer;
    color: #9b9b9b;
  }
  a:hover i {
    color: #f5a623;
  }
  table {
    width: 100%;
    background-color: white;
  }
  tr {
    border-bottom: 1px solid #e8e8e8;
    transition: background-color .25s ease;
  }
  tr:hover {
    background-color: #f2f2f2;
  }
  tr:hover th {
    background-color: transparent !important;
  }
  th, td {
  font-family:'Avenir LT Std 45 Book';
  padding: 15px 5px;
  color: #5d5d5d;
  font-size: 13px;
  display: table-cell;
  text-align: center !important;
  vertical-align: middle;
  border-radius: 2px;
  border-bottom: 1px solid #e8e8e8;
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

<style>
  .local-picker input.focus {
    border-color: #d7d7d7 !important;
    box-shadow: none !important;
    box-shadow: 0 1px 0 0 #09ca69 !important;
  }
  .datepicker-range {
    min-width: 210px !important;
  }
</style>