<template>
  <div class="search">
    
    <div class="download-container">
      <button class="btn waves-effect waves-light" @click="downloadExcel()">Descargar formato excel</button>
    </div>

    <DataTable v-if="idCampaing" :endPoint="endPoint" :headings="headings" :selectRow="selectRow" :params="{idCampaing: idCampaing}" :search="false">
      
      <template slot="legalName" slot-scope="props">
        {{ props.slotScope.legalName }}
        {{ setIdWalletByCampaign(props.slotScope.idWalletByCampaign) }}
      </template>

    </DataTable>

  </div>
</template>

<script>
  import DataTable from '@/components/DataTable';
  import axios from 'axios';
  import endPoint from '@/utils/env';
  import querystring from 'querystring';
  import AsignarAsesorDeudor from './AsignarAsesorDeudor';

  export default {
    name: 'AsignarAsesor',
    components: {
      DataTable,
      AsignarAsesorDeudor,
    },
    props: {
      idCampaing: {
        required: true,
      },
    },
    data() {
      return {
        enum: [],
        idWalletByCampaign: 0,
        endPoint: 'webapi/GetCampanasPorCliente',
        headings: {
          campana: {
            title: 'Campaña',
          },
          legalName: {
            title: 'Deudor',
            type: 'slot',
          },
          idNumber: {
            title: 'CC',
          },
          ciudad: {
            title: 'Ciudad',
          },
          fechaAsignacion: {
            title: 'Fecha Asignacion',
            type: 'datetime',
          },
          capitalValue: {
            title: 'Capital',
            type: 'number',
          },
          saldo: {
            title: 'Saldo',
            type: 'number',
          },
          estado: {
            title: 'Estado',
          },
          edad: {
            type: 'number',
            title: 'Edad',
          },
          clasificacion: {
            title: 'Clasificación',
          },
          estado_juri_prej: {
            title: 'Estado Deudor',
          },
          idAdviser: {
            title: 'Asesor',
            type: 'select',
            width: '120px',
            enum: [],
            change: (value, meta) => {
              axios.post('http://cojunal.com/plataforma/beta/webapi/AsignarAsesorCampana', querystring.stringify({
                idAdviser: value,
                idCampaign: meta.idCampaign,
              })).catch((err) => {
                console.log(err);
              });
            },
          },
        },
      };
    },
    methods: {
      setIdWalletByCampaign(id) {
        this.idWalletByCampaign = id;
        console.log('idWalletByCampaign', id);
      },
      getParmas() {
        return this.idCampaign;
      },
      downloadExcel() {
        const url = 'http://cojunal.com/plataforma/beta/webapi/DowloadDBDeudores?idCampaign='.concat(this.idWalletByCampaign);
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
        this.params.idCampaign = event.params.campana.idCampaign;
        this.headings.idAdviser.enum = event.params.enum;
      },
      selectRow(itm, e) {
        /* eslint-disable */
        axios.get('http://cojunal.com/plataforma/beta/webapi/GetSelectAsesores').then((res) => {
          if (res.status !== 200) return [];
          const asesores = [];
          res.data.map((item, index, model) => {
            asesores.push({ value: model[index].idAdviser, text: model[index].name });
            if (asesores.length === res.data.length) e.$modal.show('asignar-asesor-deudor', { campana: itm, enum: asesores });
          });
        }).catch((err) => {
          console.log(err);
        });
        /* eslint-enable */
      },
      getAsesores() {
      },
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
  .download-container {
    position: inherit;
    text-align: right;
    padding-right: 20px;
    margin-bottom: 30px;
  }
</style>