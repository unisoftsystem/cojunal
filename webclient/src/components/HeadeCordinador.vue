<template>
  <div class="header-coordinador">
    
    <div class="row">
      
      <div class="col col-7" id="bg">
        <div class="title">DEUDORES</div>
        <span class="separator"></span>
        <div class="deudor-content">
          <div class="row">
            <div class="col col-10">
                Saldo incial: 865285480 <br/>
            </div>
          </div>
          <div class="row">
            <div class="col col-3">
              Intereses: 56515110 <br/>
              Honorarios: 6262260 
            </div>
            <div class="col col-3">
              Saldo Total: 7848120 <br/>
              Saldo en mora: 4515158 
            </div>
          </div>
          <div class="row"></div>
        </div>
      </div>

      <div class="col col-3">
      </div>

    </div>

    <div class="row"></div>

  </div>
</template>

<script>
  import axios from 'axios';
  // import endPoint from '@/utils/env';
  // import querystring from 'querystring';

  export default {
    name: 'AsignarAsesor',
    components: {
    },
    props: {
    },
    data() {
      return {
      };
    },
    methods: {
    },
    created() {
      /* eslint-disable */
      axios.get('http://cojunal.com/plataforma/beta/webapi/GetSelectAsesores').then((res) => {
        if (res.status !== 200) return [];
        const asesores = [];
        res.data.map((item, index, model) => {
          this.headings.idAdviser.enum.push({ value: model[index].idAdviser, text: model[index].name });
        });
      }).catch((err) => {
        console.log(err);
      });
      /* eslint-enable */
    },
    mounted() {
    },
  };
</script>

<style scoped>
  .separator {
    width: 100px;
    height: 2px;
    background-color: white;
    display: block;
    margin-bottom: 10px;
  }
  .header-coordinador {
    margin-bottom: 20px;
    background-color: white;
    box-shadow: 5px 6px 8px rgba(202, 202, 202, 0.5);
  }
  .title {
    font-size: 23px; 
    font-weight: bold;
    /*margin: 5px 0;*/
  }
  #bg {
    padding: 20px;  
    background-image: url('http://cojunal.com/plataforma/assets/img/bg_panel.png');
    background-color: #193153;
    color: white;
    font-family: 'Avenir LT Std 45 Book' !important;
  }
  .deudor-content {
    color: rgba(255,255,255,0.65);
  }
  .row {
    clear: both;
  }
  .col {
    float: left;
  }
  .col-10 {
    width: 100%;
  }
  .col-7 {
    width: 66%;
  }
  .col-3 {
    width: 30%;
  }
</style>