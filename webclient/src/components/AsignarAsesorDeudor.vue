<template>
  <div class="search">
    
    <app-modal name="asignar-asesor-deudor" @before-open="beforeOpen">
      <div>
        <button class="waves-effect btnb" @click="downloadExcel">Exportar a Excel</button>
      </div>
<!--       <div class="filtros">
        <div class="col-6">
          <div class="form-group">
            <label for="">Nombre/Razón Social</label>
            <input type="text" v-model="prms['nombre']" @input="change">
          </div>  
          <div class="form-group">
            <label for="">Cedula/Nit</label>
            <input type="text" v-model="prms['nit']" @input="change">
          </div>
          <div class="form-group">
            <label for="">Ciudad</label>
            <input type="text" v-model="prms['ciudad']" @input="change">
          </div>
          <div class="form-group">
            <label for="">Fecha de Asignación</label>
            <input type="date" v-model="prms['fecha']" @input="change">
          </div>
          <div class="form-group">
            <label for="">Capital</label>
            <input type="number" min="0" v-model="prms['capitalValue']" @input="change">
          </div>
        </div>
        <div class="col-6">
          <div class="form-group">
            <label for="">Saldo</label>
            <input type="number" min="0" v-model="prms['saldo']" @input="change">
          </div>
          <div class="form-group">
            <label for="">Estado</label>
            <input type="text" v-model="prms['estado']" @input="change">
          </div>
          <div class="form-group">
            <label for="">Edad</label>
            <input type="number" min="0" v-model="prms['edad']" @input="change">
          </div>
          <div class="form-group">
            <label for="">Clasificación</label>
            <input type="text" v-model="prms['clasificación']" @input="change">
          </div>
          <div class="form-group">
            <label for="">Asesor</label>
            <input type="text" v-model="prms['idAdviser']" @input="change">
          </div>
        </div>
      </div> -->
      <DataTable :endPoint="endPoint" :headings="headings" :selectRow="selectRow" :params="params"/>
    </app-modal>

  </div>
</template>

<script>
  import DataTable from '@/components/DataTable';
  import axios from 'axios';
  import endPoint from '@/utils/env';
  import querystring from 'querystring';

  export default {
    name: 'AsignarAsesor',
    components: {
      DataTable,
    },
    props: {
    },
    data() {
      return {
        enum: [],
        prms: {},
        endPoint: 'webapi/GetDeudoresByCampaing',
        params: {
          idWalletByCampaign: 0,
        },
        headings: {
          nombre: {
            title: 'Nombre/Razón Social',
          },
          nit: {
            title: 'Cedula/Nit',
          },
          ciudad: {
            title: 'Ciudad',
          },
          fecha: {
            title: 'Fecha de Asignación',
          },
          capitalValue: {
            title: 'Capital',
          },
          saldo: {
            title: 'Saldo',
          },
          estado: {
            title: 'Estado',
          },
          edad: {
            title: 'Edad',
          },
          clasificación: {
            title: 'Clasificación',
          },
          idAdviser: {
            title: 'Asesor',
            type: 'select',
            enum: [],
            change: (value, meta) => {
              axios.post('http://cojunal.com/plataforma/beta/webapi/UpdateAsesorDeudor', querystring.stringify({
                idAdviser: value,
                id: meta.id,
              })).catch((err) => {
                console.log(err);
              });
            },
          },
        },
      };
    },
    methods: {
      // change() {
      //   window.busHub.$emit('updateTable', this.prms);
      // },
      downloadExcel() {
        const url = 'http://cojunal.com/plataforma/beta/webapi/DownloadExcelDeudodresCampanas?idWalletByCampaign='.concat(this.params.idWalletByCampaign);
        window.open(url);
      },
      getEndPoint() {
        return endPoint.endPoint;
      },
      onShowModal() {
        this.modal.visible = !this.modal.visible;
      },
      MODAL_OK_EVENT() {
      },
      MODAL_CANCEL_EVENT() {
      },
      beforeOpen(event) {
        this.params.idWalletByCampaign = event.params.campana.idWalletByCampaign;
        this.headings.idAdviser.enum = event.params.enum;
      },
      selectRow(itm, e) {
        axios.post('http://cojunal.com/plataforma/beta/webapi/UpdateAsesorDeudor', querystring.stringify({
          idAdviser: e.asesor,
          id: itm,
        })).catch((err) => {
          console.log(err);
        });
      },
      getAsesores() {
      },
    },
    created() {
    },
    mounted() {
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .col-6 {
    float: left;
    width: 50%;
  }
  .form-group {
    display: flex;
    justify-content: space-between;
    padding: 0 10px;
    align-items: center;
  }
  .form-group input, .form-group label {
    display: inline-flex;
  }
  .form-group label {
    font-weight: bold;
  }
  .form-group input {
    -webkit-transition: all 0.2s ease-out;
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
  .btnb {
    text-align: center;
    font-size: 14px;
    font-family: 'montserrat_bold';
    letter-spacing: 0;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    color: #fff;
    padding: 11px 26px;
    -webkit-transition: 0.4s;
    -o-transition: 0.4s;
    -ms-transition: 0.4s;
    -moz-transition: 0.4s;
    transition: 0.4s;
    overflow: hidden;
    position: relative;
    text-transform: uppercase;
    -webkit-border-radius: 2px;
    border-radius: 2px;
    display: inline-block;
    background: #09ca69;
  }

  element.style {
  }
  cojunal.css:3552
  .formweb button {
    cursor: pointer;
  }
  cojunal.css:3552
  .btnb {
    text-align: center;
    font-size: 14px;
    font-family: 'montserrat_bold';
    letter-spacing: 0;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    color: #fff;
    padding: 11px 26px;
    -webkit-transition: 0.4s;
    -o-transition: 0.4s;
    -ms-transition: 0.4s;
    -moz-transition: 0.4s;
    transition: 0.4s;
    overflow: hidden;
    position: relative;
    text-transform: uppercase;
    -webkit-border-radius: 2px;
    border-radius: 2px;
    display: inline-block;
    background: #09ca69;
  }
  .waves-effect {
    position: relative;
    cursor: pointer;
    display: inline-block;
    overflow: hidden;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    vertical-align: middle;
    z-index: 1;
    will-change: opacity,transform;
    transition: all .3s ease-out;
  }
  button {
    cursor: pointer;
    border: none;
    position: absolute;
    left: 10px;
    top: 15px;
    outline: none;
    font-weight: bold;
    font-family: 'avenir';
  }
  </style>