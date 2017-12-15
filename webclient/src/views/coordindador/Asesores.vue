<template>
  <div class="coordinador">
    
    <app-modal name="asignar-tarea">
      <AsignarTarea />
    </app-modal>

    <Container :menu="'coordinador'">
  
      <PageTitle />

      <DataTable :endPoint="endPoint" :headings="headings" :selectRow="selectRow" :search="false" :collapse="true">

        <template slot="xhracordeon" slot-scope="props">
          <DeudoresAsesor :idCampaing="props.slotScope.idAdviser"/>
        </template>

        <!-- <template slot="tarea" slot-scope="props"> -->
          <!-- {{ props }} -->
          <!-- <a class="btn-link" @click="showModal">Asignar tarea</a> -->
        <!-- </template> -->

      </DataTable>

    </Container>

  </div>
</template>

<script>
import Container from '@/components/Container';
import DataTable from '@/components/DataTable';
import AsignarAsesor from '@/components/AsignarAsesor';
import PageTitle from '@/components/PageTitle';
import AsignarTarea from '@/components/AsignarTarea';
import DeudoresAsesor from '@/components/DeudoresAsesor';
import Modal from 'vue2-flexible-modal';
import axios from 'axios';

export default {
  name: 'Asesores',
  components: {
    Container,
    DataTable,
    AsignarAsesor,
    DeudoresAsesor,
    AsignarTarea,
    PageTitle,
    Modal,
  },
  data() {
    return {
      acordeon: false,
      endPoint: 'webapi/GetAsesores',
      modal: {
        title: 'I am modal title',
        visible: false,
        text: '',
      },
      headings: {
        name: {
          title: 'Asesor',
        },
        campanas: {
          title: '# Campañas',
          type: 'number',
        },
        dCreation: {
          title: 'Fecha asignación',
          type: 'datetime',
        },
        saldoAsignado: {
          title: 'Saldo Asignado',
          type: 'number',
        },
        recuperado: {
          title: 'Total recuperado',
          type: 'number',
        },
        porcentaje: {
          title: '% Recuperacion',
          type: 'number',
        },
        deudores: {
          title: '# Deudores',
          type: 'number',
        },
        // tarea: {
        //   title: 'Acciones',
        //   type: 'slot',
        // },
      },
    };
  },
  methods: {
    showModal() {
      console.log('hola', this.$modal);
      this.$modal.show('asignar-tarea');
    },
    selectRow: (itm, e) => {
      /* eslint-disable */
      axios.get('http://cojunal.com/plataforma/beta/webapi/GetSelectAsesores').then((res) => {
        if (res.status !== 200) return [];
        const asesores = [];
        res.data.map((item, index, model) => {
          asesores.push({ value: model[index].idAdviser, text: model[index].name });
          if (asesores.length === res.data.length) e.$modal.show('asignar-asesor', { campana: itm, enum: asesores });
        });
      }).catch((err) => {
        console.log(err);
      });
      /* eslint-enable */
    },
  },
  created() {
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
