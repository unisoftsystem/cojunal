<template>
  <div class="asignar-tarea">
    
    <div class="asignar-tarea--container">
    
      <form v-on:submit.prevent="onSubmit(form)">

        <div class="row">
          
          <div class="col-6">
            <!-- accion -->
            <div class="form-group">
              <label for="action">Accion *</label>
              <!-- {{ $route.params }} -->
              <input type="hidden" v-model="form.idWallet">
              <input type="hidden" v-model="form.idAdviser">
              <select v-model="form.action">
                <option v-for="itm in enumAcions" v-bind:value="itm.idAction">{{ itm.actionName }}</option>
              </select>
            </div>
            <!-- efectos -->
            <div class="form-group">
              <label for="efect">Efectos </label>
              <select v-model="form.efects">
                <template v-for="itm in enumEfects" >
                  <option v-bind:value="itm.idEffect" v-show="itm.idAction == form.action">
                    {{ itm.effectName }}
                  </option>
                </template>
              </select>
            </div>
            <!-- comentarios -->
            <div class="form-group">
              <label for="comments">Comentarios</label>
              <textarea v-model="form.comments" rows="3"></textarea>
            </div>
          </div>
          
          <div class="col-6">
            <!-- tiṕo -->
            <div class="form-group checkboxitem">
              <label @click="checked='task'; form.type='task'">
                <input type="checkbox" :class="{active: checked==='task'}">
                <span class="checkbox-label">Tarea</span>
              </label>
              <label @click="checked='promise'; form.type='promise'">
                <input type="checkbox" :class="{active: checked==='promise'}">
                <span class="checkbox-label">Promesa</span>
              </label>
            </div>
            <!-- accion -->
            <div class="form-group" v-if="checked==='task'">
              <label for="action">Accion *</label>
              <select v-model="form.taskAction">
                <option v-for="itm in enumAcions"  v-bind:value="itm.idAction">{{ itm.actionName }}</option>
              </select>
            </div>
            <!-- value -->
            <div class="form-group" v-if="checked==='promise'">
              <label for="value">Valor *</label>
              <input type="number" v-model="form.value">
            </div>
            <!-- date -->
            <div class="form-group">
              <label>Fecha</label>
              <vue-datepicker-local class="local-picker" :local="localPicker" v-model="form.date" clearable />
              <!-- <date-picker v-model="startTime" :option="option"></date-picker> -->
            </div>
            <!-- submit -->
          </div>

          <div class="clear"></div>
          
          <div class="form-group">
            <button type="submit" class="btn waves-effect waves-light btn-block">Guardar</button>
          </div>
          
        </div>
      
      </form>

      <div class="clear"></div>

    </div>


  </div>
</template>

<script>
  import axios from 'axios';
  import VueDatepickerLocal from 'vue-datepicker-local';
  import myDatepicker from 'vue-datepicker2';
  import querystring from 'querystring';
  import moment from 'moment';
  import datePickerLocal from '../utils/datePickerLocal';

  export default {
    name: 'AsignarTarea',
    components: {
      VueDatepickerLocal,
      'date-picker': myDatepicker,
    },
    props: {
    },
    data() {
      return {
        checked: 'task',
        localPicker: datePickerLocal,
        enumAcions: [],
        enumEfects: [],
        date: new Date(),
        form: {
          action: '',
          efects: '',
          comments: '',
          value: '',
          task: '',
          idWallet: this.$route.params.idWallet,
          idAdviser: this.$route.params.idAdviser,
          date: new Date(),
          taskAction: '',
          type: 'task',
        },
      };
    },
    methods: {
      onSubmit: (params) => {
        let params1 = {};
        params1 = Object.assign(params1, params);
        params1.date = moment(params.date).format('YYYY/MM/DD').toString();
        console.log(params1);
        axios.post('http://cojunal.com/plataforma/beta/Webapi/AsignarTarea', querystring.stringify(params1)).then((res) => {
          console.log(res);
          this.form = {};
        }).catch((err) => {
          alert(err);
          console.log(err);
        });
      },
    },
    created() {
      axios.get('http://cojunal.com/plataforma/beta/Webapi/GetSelectActions').then((res) => {
        if (res.status === 200 && res.data) {
          res.data.map((itm) => {
            this.enumAcions.push(itm);
            console.log(itm);
            return 1;
          });
        }
      }).catch((err) => {
        console.log(err);
      });

      axios.get('http://cojunal.com/plataforma/beta/Webapi/GetSelectEfects').then((res) => {
        if (res.status === 200 && res.data) {
          this.enumEfects = [];
          res.data.map((itm) => {
            this.enumEfects.push(itm);
            console.log(itm);
            return 1;
          });
        }
      }).catch((err) => {
        console.log(err);
      });
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  button[type="submit"] {
    width: 100%;
    margin-left: -10px;
  }
  .form-group input {
    max-width: 300px !important;
  }
  .clear {
    clear: both;
  }
  .title {
    color: #193153;
    font-size: 15px;
    letter-spacing: 0;
    text-transform: uppercase;
    letter-spacing: 0;
    font-weight: 600;
    border-bottom: 1px solid #d8d8d8;
    margin-bottom: 20px;
    margin-top: 20px;
  }
  .datepicker.local-picker {
    width: 100% !important;
    max-width: 300px;
  }
  .checkboxitem {
    padding-left: 30%;
    padding-right: 10px;
  }
  .checkbox-label {
    margin-top: 5px; 
  }
  .asignar-tarea {
    padding: 16px;
    font-family: 'Avenir LT Std 45 Book';
    background: white;
    padding-top: 40px;
    padding-bottom: 40px;
  }
  input[type="checkbox"] {
    margin-right: 20px;
    border-radius: 50%;
    height: 26px;
    border-color: #eee;
    margin-bottom: 19px;
  }
  input:focus, select:focus, textarea:focus {
    outline: none !important;
  }
  .active {
    background: #09ca69;
  }
  .datepicker:before {
    top: -5px;
  }
</style>
<style>
  .datepicker>input {
    max-width: 300px;
  }
</style>