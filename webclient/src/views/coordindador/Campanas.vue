<template>
  <div class="coordinador">

    <Container :menu="'coordinador'">

      <HeadeCordinador />

      <PageTitle />

      <DataTable :endPoint="endPoint" :headings="headings" :search="false" :collapse="true" :selectRow="selectRow" v-on-clickaway="away">

        <template slot="xhracordeon" slot-scope="props">
          <AsignarAsesor :idCampaing="props.slotScope.idWalletByCampaign" />
        </template>

        <template slot="download" slot-scope="props">
            <a class="btn-link" @click="downloadExcel(props.slotScope.idCampaign)">Descargar formato excel</a>
        </template>

      </DataTable>

    </Container>

  </div>
</template>

<script>
import Container from '@/components/Container';
import PageTitle from '@/components/PageTitle';
import DataTable from '@/components/DataTable';
import AsignarAsesor from '@/components/AsignarAsesor';
import HeadeCordinador from '@/components/HeadeCordinador';
import Modal from 'vue2-flexible-modal';
import { mixin as clickaway } from 'vue-clickaway';
// import axios from 'axios';

export default {
  name: 'Campanas',
  mixins: [clickaway],
  components: {
    Container,
    DataTable,
    PageTitle,
    AsignarAsesor,
    HeadeCordinador,
    Modal,
  },
  data() {
    return {
      activateAsignarAsesor: false,
      endPoint: 'webapi/GetCoordinadorBandejaEntrada',
      modal: {
        title: 'I am modal title',
        visible: false,
        text: '',
      },
      headings: {
        name: {
          title: 'Nombre',
        },
        campanas: {
          title: '# Campañas',
          type: 'number',
        },
        total: {
          title: 'Valor total',
          type: 'number',
        },
        saldo: {
          title: 'Saldo a la fecha',
          type: 'number',
        },
        recaudo: {
          title: '% Recaudo',
          type: 'number',
        },
        deudores: {
          title: '# Deudores',
          type: 'number',
        },
        download: {
          title: '# Descargar',
          type: 'slot',
        },
      },
    };
  },
  methods: {
    downloadExcel(id) {
      const url = 'http://cojunal.com/plataforma/beta/webapi/DowloadDBDeudoresConCampana?idCampaign='.concat(id);
      window.open(url);
    },
    selectRow(row, scope) {
      console.log(row, scope);
    },
    away() {
      console.log('away');
    },
    // selectRow(itm, scope) {
      // this.$emit('openAsignarAsesorCoordinador', { item: itm, event: scope });
      /* eslint-disable */
      // axios.get('http://cojunal.com/plataforma/beta/webapi/GetSelectAsesores').then((res) => {
      //   if (res.status !== 200) return [];
      //   const asesores = [];
      //   res.data.map((item, index, model) => {
      //     asesores.push({ value: model[index].idAdviser, text: model[index].name });
      //     if (asesores.length === res.data.length) e.$modal.show('asignar-asesor', { campana: itm, enum: asesores });
      //   });
      // }).catch((err) => {
      //   console.log(err);
      // });
      /* eslint-enable */
    // },
  },
  mounted() {
    setTimeout(() => {
      this.activateAsignarAsesor = true;
    }, 1000);
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
