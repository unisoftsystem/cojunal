<template>
  <div class="tareas">
  
    <Container :menu="'coordinador'">
  
      <PageTitle />
      
      <div class="tareas-container">
        
        <div class="row">
          
          <div class="col col-6">
            <div class="tarea-head"><b>Hoy</b> <span class="tareas-span hoy"> {{ hoy }}</span></div>
            <template v-for="task in tareas">
              <div class="row" v-show="isTaskOfDay(task)">
                <div class="col col-9">{{ task.comment }}</div>
                <!-- <div class="col col-3">{{ task.dAction }}</div> -->
              </div>
            </template>
          </div>

          <div class="col col-6">
            <div class="tarea-head"><b>Todas</b> <span class="tareas-span todas"></span></div>
            <template v-for="task in tareas">
              <div class="row" v-show="isTaskNextDays(task)">
                <div class="col col-9">{{ task.comment }}</div>
                <div class="col col-3">{{ task.dAction }}</div>
              </div>
            </template>
          </div>

        </div>

      </div>    
      
      <div class="row"></div>

      <!-- <div>
        <pre>{{ tareas }}</pre>
      </div> -->
    
      <div class="row"></div>

    </Container>
  
  </div>
</template>

<script>
import axios from 'axios';
import moment from 'moment-with-locales-es6';
import Container from '../../components/Container';
import PageTitle from '../../components/PageTitle';

export default {
  name: 'AsignarTarea',
  components: {
    Container,
    PageTitle,
  },
  data() {
    return {
      tareas: [],
      hoy: moment().format('LL'),
    };
  },
  methods: {
    /* eslint-disable */
    isTaskOfDay: (value) => (moment(value.dAction).diff(new Date(), 'days') === 0),
    isTaskNextDays: (value) => (moment(value.dAction).diff(new Date(), 'days') > 0),
    /* eslint-disable */
  },
  created() {
    moment.locale('es');
    moment().format('LL');
    /* eslint-disable */
      axios.get('http://cojunal.com/plataforma/beta/webapi/GetTareas').then((res) => {
        if (res.status !== 200) return [];
        console.log(res);
        this.tareas = res.data;
      }).catch((err) => {
        console.log(err);
      });
      /* eslint-enable */
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .tareas-container {
    font-family: 'Avenir LT Std 45 Book';
    background: white;
    display: inline-block;
    width: 100%;
    padding: 20px 5px 40px; 
    color: #646464;
  }
  .tarea-head {
    margin-right: 20px;
    border-bottom: 1px solid #d0d0d0;
    padding-bottom: 10px;
  }
  .tareas-span {
    float: right;
  }
  .tareas-span:after {
    content: '';
    width: 20px;
    height: 20px;
    display: inline-block;
    margin-left: 20px;
    border-radius: 50%;
    box-shadow: 0px 0px 10px #00000061;
  }
  .hoy.tareas-span:after {
    background-color: #f5a623;
  }
  .todas.tareas-span:after {
    background-color: #53cb68;
  }
  .row {
    padding: 16px; 
    clear: both;
  }
  .col {
    float: left;
  }
  .col-6 {
    width: 50%;
  }
  .col-9 {
    width: 75%;
  }
  .col-3 {
    width: 25%;
  }
</style>
